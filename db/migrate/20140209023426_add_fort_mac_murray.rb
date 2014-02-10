class AddFortMacMurray < ActiveRecord::Migration
  def up
  	fortMac=Community.create(:name=>"Fort McMurray")
  	fortMac.save

  	Location.where(:name=>"Fort MacMurray").each do |location|
  		location.community=fortMac
  		location.save
  	end
  	Location.where(:name=>"Fort McMurray").each do |location|
  		location.community=fortMac
  		location.save
  	end  	
  end

  def down
  	fortMac = Community.find_by_name("Fort McMurray")

  	Location.where(:community_id=>fortMac.id).each do |location|

  		location.community_id=nil
  		location.save
  	end

  	fortMac.destroy
  end
end
