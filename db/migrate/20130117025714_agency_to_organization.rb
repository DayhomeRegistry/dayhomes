class AgencyToOrganization < ActiveRecord::Migration
  def change
  	create_table :organizations do |t|
	    t.string   "name"
	    t.string   "city"
	    t.string   "province"
	    t.string   "street1"
	    t.string   "street2"
	    t.string   "postal_code"
	    t.string   "billing_email"
	    t.string   "phone_number"
	    t.string   :stripe_customer_token
    	t.string   :plan,  :default => 'baby'

	    t.timestamps
	end
	create_table :organization_users do |t|
      t.column :user_id, :integer
      t.column :organization_id, :integer

      t.timestamps
    end
	User.find(:all, :include => "user_day_homes", :conditions => ["user_day_homes.day_home_id IS NOT NULL"]).each do |user|
		user.day_homes.each do |dayhome|
			org = Organization.new(
				:name => dayhome.name, 
				:city => dayhome.city,
				:province => dayhome.province,
				:street1 => dayhome.street1,
				:street2 => dayhome.street2,
				:postal_code => dayhome.postal_code,
				:phone_number => dayhome.phone_number,
				:stripe_customer_token => user.stripe_customer_token
			)
			org.save
			org.users << user
			org.save
		end
	end

	Agency.all.each do |agency|
		stripe = nil
		agency.users.each do |u|
			if !u.stripe_customer_token.nil?
				stripe=u.stripe_customer_token
				break
			end
		end
		org = Organization.new(
			:name => agency.name,
			:city => agency.city,
			:province => agency.province,
			:street1 => agency.street1,
			:street2 => agency.street2,
			:postal_code => agency.postal_code,
			:phone_number => agency.phone_number,
			:stripe_customer_token => stripe
		)
		org.save
		org.users << agency.users
		org.save
	end
  end
end
