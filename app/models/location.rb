class Location < ActiveRecord::Base
	has_one :organization, :through=>:organization_locations

	has_many :location_day_homes, :dependent=>:destroy
	has_many :day_homes, :through=>:location_day_homes
end
