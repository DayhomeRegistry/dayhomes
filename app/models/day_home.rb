class DayHome < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :address, :gmaps, :enrolled, :max_enrollment

  validates :name,  :presence => true
  validates :enrolled, :numericality => { :only_integer => true, :less_than_or_equal_to  => :max_enrollment }
  validates :max_enrollment, :numericality => { :only_integer => true, :greater_than_or_equal_to  => :enrolled }

  acts_as_gmappable :lat => 'lat', :lng => 'lng', :check_process => :prevent_geocoding,
                    :address => 'address', :normalized_address => 'address',
                    :msg => 'Cannot find a location matching that query.'

  def prevent_geocoding
    address.blank? || (!lat.blank? && !lng.blank?)
  end
end
