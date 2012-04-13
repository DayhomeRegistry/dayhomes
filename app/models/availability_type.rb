class AvailabilityType < ActiveRecord::Base
  attr_accessor :checked  # used for search checkbox

  validates_presence_of :kind, :availability
  
  scope :full_time, where("availability_types.availability = 'Full-time'")
  scope :part_time, where("availability_types.availability = 'Part-time'")
  
end
