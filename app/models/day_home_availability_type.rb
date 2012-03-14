class DayHomeAvailabilityType < ActiveRecord::Base
  belongs_to :dayhome
  belongs_to :availability_type

end
