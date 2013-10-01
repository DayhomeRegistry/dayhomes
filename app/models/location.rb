class Location < ActiveRecord::Base
	belongs_to :organization

	has_many :day_homes
	has_many :users
	has_one :community
end
