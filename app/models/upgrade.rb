class Upgrade < ActiveRecord::Base
  attr_accessor :stripe_card_token

  has_one :plan
end
