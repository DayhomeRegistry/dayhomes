class DayHome < ActiveRecord::Base
  attr_accessible :name, :lat, :lng, :address, :gmaps

  validates :name,  :presence => true

  # :address is where you get the address from
  # :normalized_address will apply the clean gmaps address (over writing the previous address))
  # IE: d = DayHome.create!({:name => 'Ryan House', :address => 'T6L5M6'})
  #   #<DayHome id: 5, name: "ryans house", lat: 53.47759199999999, lng: -113.395897, address: "Edmonton, AB T6L 5M6, Canada"
  acts_as_gmappable :lat => 'lat', :lng => 'lng', :check_process => :prevent_geocoding,
                    :address => 'address', :normalized_address => 'address',
                    :msg => 'Cannot find a location matching that query.'

  def prevent_geocoding
    address.blank? || (!lat.blank? && !lng.blank?)
  end
end
