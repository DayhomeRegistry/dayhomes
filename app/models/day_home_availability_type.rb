class DayHomeAvailabilityType < ActiveRecord::Base
  validates_presence_of :day_home_id, :availability_type_id

  belongs_to :dayhome
  belongs_to :availability_type

end
