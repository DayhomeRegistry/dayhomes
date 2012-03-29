class DayHome < ActiveRecord::Base

  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => true,
                    :check_process => :prevent_geocoding, :address => :address,
                    :msg => 'Cannot find a location matching that query.'

  scope :with_availability_uniq, lambda { |default_availability_types|
    joins(:availability_types).
    where("availability_types.availability IN (?) AND availability_types.kind = ?", default_availability_types[:availability], default_availability_types[:kind]).
    uniq
  }
  
  scope :featured, where(:featured => true)

  # availability types
  has_many :day_home_availability_types
  has_many :availability_types, :through => :day_home_availability_types
  has_many :photos, :class_name => 'DayHomePhoto', :dependent => :destroy

  # certification types
  has_many :day_home_certification_types
  has_many :certification_types, :through => :day_home_certification_types

  validates :name, :street1, :city, :province, :postal_code, :slug, :presence => true
  validates_associated :photos
  validates_uniqueness_of :slug
  
  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true

  # this method is called when creating or updating a dayhome
  # it won't make a call to google maps if we already have a lat long however,
    # this method seems to be ignored on update
  def prevent_geocoding
    (!lat.blank? && !lng.blank?)
  end
  
  def featured_photo
    photos.first
  end
  
  # this method is called when updating the lat long (this is what's fed to google maps)
  def address
    "#{city}, #{province}, Canada #{postal_code}"
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
end
