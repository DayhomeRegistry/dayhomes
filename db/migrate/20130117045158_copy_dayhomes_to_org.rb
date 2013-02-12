class CopyDayhomesToOrg < ActiveRecord::Migration
  def down
  	Organization.all.each do |org|
  		org.destroy
  	end
  	Location.all.each do |l|
  		l.destroy
  	end

  	remove_column :users,:organization_id
  end
  def up
  	drop_table :organization_users #permanent
 	add_column :users, :organization_id, :integer
 	

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
			user.organization = org
			user.save
			l = Location.new(
	    		:name => org.city
	    	)
	    	l.save
	    	org.locations << l
	    	l.day_homes << dayhome
	    	l.save
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
		agency.users.each do |u|
			u.organization=org
			u.save
		end
		#org.users << agency.users
		#org.save
		l = Location.new(
    		:name => org.city
    	)
    	l.save
    	org.locations << l
    	l.day_homes << agency.day_homes
    	l.save
	end

  end
end
