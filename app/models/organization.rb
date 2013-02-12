  class Organization < ActiveRecord::Base
  
  has_many :users
  #has_many :organization_users, :dependent => :destroy
  #has_many :users, :through => :organization_users

  has_many :locations
  has_many :day_homes, :through=>:locations

  attr_accessor :stripe_card_token
  
  before_destroy :destroy_customer
  
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