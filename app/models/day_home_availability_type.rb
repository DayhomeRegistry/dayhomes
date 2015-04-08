class DayHomeAvailabilityType < ActiveRecord::Base
  validates_presence_of :day_home, :availability_type

  belongs_to :day_home
  belongs_to :availability_type

end
