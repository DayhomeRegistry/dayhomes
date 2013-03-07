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
 	

	#User.find(:all, :include => "user_day_homes", :conditions => ["user_day_homes.day_home_id IS NOT NULL"]).each do |user|
	#User.includes(:user_day_homes).where("user_day_homes.user_id is not null").each do |user|
	User.where("id in (select user_id from user_day_homes)").each do |user|
		org = Organization.create!(
			:name => user.day_homes.first.name, 
			:city => user.day_homes.first.city,
			:province => user.day_homes.first.province,
			:street1 => user.day_homes.first.street1,
			:street2 => user.day_homes.first.street2,
			:postal_code => user.day_homes.first.postal_code,
			:phone_number => user.day_homes.first.phone_number,
			:stripe_customer_token => user.stripe_customer_token 
		)
		#say(org.to_json)
		user.organization = org
		if(!org.save)
			raise org.errors.full_messages.join(',')
		end
		if(!user.save)
			raise user.errors.full_messages.join(',')
		end		
		say(user.organization.to_json);
		l = Location.new(
    		:name => org.city
    	)
    	l.save
    	org.locations << l
	   	org.save
	   	l.save
	   	
		user.day_homes.each do |dayhome|
			l.day_homes<<dayhome
			if(!dayhome.save)
				raise dayhome.errors.full_messages.join(',')
			end
		end
		l.save
		#update day_homes set highlight="Aunties is a Dayhome full of love, fun and laughter." where id =1;

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
