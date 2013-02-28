  class Organization < ActiveRecord::Base
  
  has_many :users
  #has_many :organization_users, :dependent => :destroy
  #has_many :users, :through => :organization_users

  has_many :locations
  has_many :day_homes, :through=>:locations

  has_many :features

  attr_accessor :stripe_card_token
  
  before_destroy :destroy_customer
  
  def feature_count
    update_free_features()

    self.features.where("day_home_id is null").count

  end

  def update_free_features
    #need to add enough "empty" features for the month
    # how many freebees based on plan
    plan = Plan.find_by_name(self.plan).free_features
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
    to_create = [(plan - started - freebees),0].max
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
          customer = Stripe::Customer.create(email: billing_email, description: name, plan: plan, card: stripe_card_token)
          #raise customer.to_json
          self.stripe_customer_token = customer.id
        else
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.card = stripe_card_token
          customer.save
        end
      else
        #check to make sure that we're not downgrading
        plan = Plan.find_by_plan(self.plan).price
        if plan==0 && !self.stripe_customer_token.nil?
          #if the customer_token is nil, there's nothing to cancel
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.cancel_subscription
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
    customer = Stripe::Customer.retrieve(self.stripe_customer_token)
    customer.delete
    
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while removing customer: #{e.message}"
    errors.add :base, "There was a problem with removing your credit card: #{e.message}"
    false
  end
end