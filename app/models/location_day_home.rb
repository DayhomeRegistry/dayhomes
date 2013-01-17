class LocationDayHome < ActiveRecord::Base
  belongs_to :location
  belongs_to :day_home
  
  validates_uniqueness_of :day_home_id, :scope => :location_id
end