class DayHome < ActiveRecord::Base

  validates :name, :street1, :city, :province, :postal_code, :presence => true

  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => true,
                    :check_process => :prevent_geocoding, :address => :address,
                    :msg => 'Cannot find a location matching that query.'

  has_many :day_home_availability_types
  has_many :availability_types, :through => :day_home_availability_types


  # this method is called when creating or updating a dayhome
  # it won't make a call to google maps if we already have a lat long however,
    # this method seems to be ignored on update
  def prevent_geocoding
    (!lat.blank? && !lng.blank?)
  end

  # this method is called when updating the lat long (this is what's fed to google maps)
  def address
    "#{city}, #{province}, Canada #{postal_code}"
  end

end
