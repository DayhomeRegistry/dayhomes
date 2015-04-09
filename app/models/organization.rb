class Organization < ActiveRecord::Base
  
  has_many :users

  has_one :logo, :class_name => "OrganizationPhoto", :foreign_key => "logo_id"
  has_one :pin, :class_name => "OrganizationPhoto", :foreign_key => "pin_id"
  # #has_and_belongs_to :logo, :class_name => 'OrganizationPhoto', :dependent => :destroy
  accepts_nested_attributes_for :logo, :allow_destroy => true #,:reject_if => :all_blank
  
  # #has_and_belongs_to :pin, :class_name => 'OrganizationPhoto', :dependent => :destroy
  accepts_nested_attributes_for :pin, :allow_destroy => true #,:reject_if => :all_blank

  has_many :locations
  has_many :day_homes, :through=>:locations

  has_many :features
  has_many :upgrades

  has_many :mentorees , :foreign_key => 'affiliate_id', :class_name => "Organization"
  belongs_to :mentor,  :foreign_key => 'affiliate_id', :class_name => "Organization"

  attr_accessor :stripe_card_token, :stripe_coupon_code
  #attr_accessible :name, :phone_number, :street1, :street2, :city, :province, :postal_code, :blurb, :stripe_card_token
  
  before_save :check_and_update_affiliate_tag
  before_destroy :destroy_customer

  #validates :billing_email, :presence => true
  #validates_format_of :billing_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  def check_and_update_affiliate_tag
    if self.affiliate_tag.nil?
      a = [('0'..'9')].map { |i| i.to_a }.flatten
      b = [('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...3).map { b[rand(b.length)] }.join
      string += (0...2).map { a[rand(a.length)] }.join
      string += (0...3).map { b[rand(b.length)] }.join
      self.affiliate_tag=string
    end
  end

  def address
    lstreet = "#{street1}#{street2}".blank? ? "" : "#{street1}#{street2},"
  	lcity = "#{city}".blank? ? "" : " #{city},"
	
    lstreet+lcity+ ("#{province}".blank? ? "":" #{province},") + " #{postal_code}"
    #{}"#{street1}#{street2}, #{city}, #{province}, #{postal_code}"
  end
  def max_dayhomes
    Plan.find_by_plan(self.plan).day_homes
  end
  def max_users
    Plan.find_by_plan(self.plan).staff
  end
  def plan_name
    plan = Plan.find_by_plan(self.plan)
    begin
      plan.name
    rescue
      raise self.plan.to_s + plan.to_json + Plan.all.to_json
    end
  end
  def feature_count
    update_free_features()

    self.features.where("day_home_id is null").count

  end
  def unlimted_features?
    Plan.find_by_plan(self.plan).free_features == -1
  end
  def payments
    payments = {}
    if (!self.stripe_customer_token.nil?)
      payments = Stripe::Invoice.all(
        :customer => self.stripe_customer_token,
        :count => 100
      )
    end
    payments
  end

  def update_free_features
    #need to add enough "empty" features for the month
    # how many freebees based on plan
    plan = Plan.find_by_plan(self.plan).free_features
    #raise plan.to_json

    # how many active freebee features are 
    #range = Time.now().beginning_of_day..1.month.from_now
    #started = self.features.where("freebee is true").find(:all, :conditions=>{:start => range}).count || 0
    started = self.features.where("freebee is true and end > ?", Time.now()).count || 0
    #raise started.to_json

    # how many freebees are there now
    freebees = self.features.where("freebee is true").where("day_home_id is null").count || 0
    #raise freebees.to_json

    # how many to create
    # 5 - 1 - 4 
    to_create = 5-freebees
    #raise "[(plan - started - freebees),0].max=[("+plan.to_s+" - "+ started.to_s + " - " + freebees.to_s + "),0].max="+[(plan - started - freebees),0].max.to_s
    if plan >= 0
      to_create = [(plan - started - freebees),0].max
    end
    #øraise to_create.to_json

    Feature.transaction do
      to_create.times do |i|
        feature = Feature.new()
        feature.organization = self
        feature.freebee = true
        saved = saved & feature.save
      end
    end
  end

  def save_with_payment 
    if valid?
      #raise stripe_card_token.blank?.to_s
      if !stripe_card_token.blank?
        if self.stripe_customer_token.nil?
          trial_end = "now"
          month = Time.now().month
          today = Time.now().day
          if (Time.days_in_month(month)/2<today)
            trial_end = 1.month.since.beginning_of_month.utc.to_i
          end
          customer = Stripe::Customer.create(email: billing_email, description: name, plan: plan, card: stripe_card_token, trial_end: trial_end, coupon: stripe_coupon_code)          
          self.stripe_customer_token = customer.id
        else
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.subscriptions.each do |subscription|
            if(subscription.plan.id != self.plan)
              customer.update_subscription(:plan => self.plan, :card=>stripe_card_token, :prorate=>true, coupon: stripe_coupon_code)
            else
              customer.card = stripe_card_token
              customer.save
            end
          end
        end
      else
        #check to make sure that we're not downgrading
        plan = Plan.find_by_plan(self.plan)
        if plan.price==0 && !self.stripe_customer_token.nil?
          #if the customer_token is nil, there's nothing to cancel
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.cancel_subscription
        elsif !self.stripe_customer_token.nil?
        #update the subscription to the new plan  
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.subscriptions.each do |subscription|
            if(subscription.plan.id != self.plan)
              #customer.update_subscription(:plan => self.plan, :prorate=>true)
              subscription.plan = self.plan
              subscription.prorate = true
              subscription.save
            else
              #Check the name
              if(customer.description != self.name)
                customer.description = self.name
                customer.save
              end
            end
          end
          customer.save
        end 
      end      
      save!
    end
  rescue Stripe::InvalidRequestError => e
    #raise e.to_json
    logger.error "Stripe error while creating customer: #{e.message}"
    self.errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  rescue Stripe::CardError => e
    #raise e.to_json
    logger.error "Stripe error while creating customer: #{e.message}"
    self.errors.add :base, e.message
    false  
  end

  def destroy_customer
    if !self.stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      customer.delete
    end
    
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while removing customer: #{e.message}"
    errors.add :base, "There was a problem with removing your credit card: #{e.message}"
    false
  end
  
  def buy_features(number)
    if (self.stripe_customer_token.nil?)
      self.errors.add :base, "Hmmm...looks like you'll need to update your credit card information before you do that."
      return false
    end
    price = 0
    case
    when (number.to_i >= 100)
      price = 1.00
    when (number.to_i >= 12)
      price = 2.50
    else
      price = 5.00
    end
    
    #integer in cents
    amount = (number.to_i * price * 100).to_i
    #self.errors.add :base, amount.to_s
    #return false
    Stripe::InvoiceItem.create(
        :customer => self.stripe_customer_token,
        :amount => amount,
        :currency => "cad",
        :description => "#{number} feature #{number.to_i>1 ? 'credits' : 'credit'}"
    )
    return true
  rescue Stripe::InvalidRequestError => e
    #raise e.to_json
    logger.error "Stripe error while buying features: #{e.message}"
    self.errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  rescue Stripe::CardError => e
    #raise e.to_json
    logger.error "Stripe error while buying features: #{e.message}"
    self.errors.add :base, e.message
    false  
  end

  def credit_card
    if(!self.stripe_customer_token.nil?)
      
      customer = Stripe::Customer.retrieve(self.stripe_customer_token)
      card = customer.cards.retrieve(customer.default_card)

      #raise customer.to_json
      credit_card = {
        last4: card.last4,
        month: card.exp_month,
        year: card.exp_year
      }   
    end
  end
end