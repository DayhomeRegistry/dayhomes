class Upgrade < ActiveRecord::Base
  attr_accessor :stripe_card_token

	has_one :new_plan, 	
          :class_name => "Plan",
          :foreign_key => 'id'
	has_one :old_plan, 
          :class_name => "Plan", 
          :foreign_key => 'id'
end
