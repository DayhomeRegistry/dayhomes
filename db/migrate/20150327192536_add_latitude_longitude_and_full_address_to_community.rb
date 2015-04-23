class AddLatitudeLongitudeAndFullAddressToCommunity < ActiveRecord::Migration
  def up
    add_column :communities, :latitude, :float
    add_column :communities, :longitude, :float
    add_column :communities, :full_address, :string

    Community.all.each do |community|
    	community.full_address = community.name + ", AB, Canada"
    	community.save
    end
    Community.not_geocoded.find_each() do |obj|
      obj.geocode; obj.save
    end
  end
  def down
  	remove_column :communities, :latitude
    remove_column :communities, :longitude
    remove_column :communities, :full_address
  end
end
