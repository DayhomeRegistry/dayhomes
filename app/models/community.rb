class Community < ActiveRecord::Base
  #attr_accessible :name
  has_many :locations

  geocoded_by :full_address   # can also be an IP address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.full_address_changed? }
end
