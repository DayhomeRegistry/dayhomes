class AvailabilityType < ActiveRecord::Base
  attr_accessor :checked  # used for search checkbox

  validates_presence_of :kind
end
