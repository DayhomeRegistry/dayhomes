class User < ActiveRecord::Base
  acts_as_authentic
  #validates_presence_of :first_name, :last_name

  has_many :reviews
  has_many :user_day_homes, :dependent => :destroy
  has_many :day_homes, :through => :user_day_homes
  
  has_many :user_agencies, :dependent => :destroy
  has_many :agencies, :through => :user_agencies

  has_one :organization, :through => :user_organizations

  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  attr_accessor :stripe_card_token
  
  before_destroy :destroy_customer
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def deliver_password_reset_instructions!
    UserMailer.password_reset_instructions(self).deliver
  end
  
  def day_home_owner?
    day_homes.any? 
  end
  def organization_admin?
    agencies.any?
  end
  def dayhome_admin?
    agencies.any?||day_homes.any?
  end
  
  def assign_day_home_ids=(day_home_id_attrs=[])
    self.user_day_homes = []
    self.day_homes = DayHome.find_all_by_id(day_home_id_attrs)
  end
  def self.all_for_select
    all.collect {|user| [ user.full_name, user.id ] }
  end
  def self.unassigned_for_select
    User.find(:all, :include => "user_day_homes", :conditions => ["user_day_homes.day_home_id IS NULL"]).collect {|user| [user.full_name,user.id]}
  end
  def add_day_home(day_home)
    if (self.agencies.count != 0) then
      raise "A user can't have an agency and a dayhome"
    end
    self.day_homes<<(day_home)
  end
  def add_agency(agency)
    if (self.day_homes.count != 0) then
      raise "A user can't have an agency and a dayhome"
    end
    self.agencies<<(agency)
  end  
  def self.new_from_fb_user(fb_user, fb_access_token, fb_expires_in)
    random_password = SecureRandom.hex(12)
    new({
      :first_name => fb_user['first_name'],
      :last_name => fb_user['last_name'],
      :email => fb_user['email'],
      :password => random_password,
      :password_confirmation => random_password,
      :facebook_access_token => fb_access_token,
      :facebook_access_token_expires_in => fb_expires_in
    })
  end
  
  def self.new_from_signup_request(signup_request)
    random_password = SecureRandom.hex(12)
    new({
      :first_name => signup_request.first_name,
      :last_name => signup_request.last_name,
      :email => signup_request.contact_email , 
      :plan => signup_request.plan,    
      :password => random_password,
      :password_confirmation => random_password
    })
  end
  
  
  def save_with_payment 
    if valid?
      #raise stripe_card_token.blank?.to_s
      if !stripe_card_token.blank?
        if self.stripe_customer_token.nil?
          customer = Stripe::Customer.create(email: email, description: full_name, plan: plan, card: stripe_card_token)
          #raise customer.to_json
          self.stripe_customer_token = customer.id
        else
          customer = Stripe::Customer.retrieve(self.stripe_customer_token)
          customer.card = stripe_card_token
          customer.save
        end
      end
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card: #{e.message}"
    false
  rescue Stripe::CardError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, e.message
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