class Availability < ActiveRecord::Base

  has_many :day_homes
  has_many :day_homes, :through => :availabilities


end