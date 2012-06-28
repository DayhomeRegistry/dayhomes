class DayHome < ActiveRecord::Base

  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => true,
                    :check_process => :prevent_geocoding, :address => :address,
                    :msg => 'Cannot find a location matching that query.'

  # scopes
  scope :with_availability_uniq, lambda { |default_availability_types|
    joins(:availability_types).
    where("availability_types.availability IN (?) AND availability_types.kind = ?", default_availability_types[:availability], default_availability_types[:kind]).
    uniq
  }
  scope :featured, where(:featured => true)

  # availability types
  has_many :day_home_availability_types, :dependent => :destroy
  has_many :availability_types, :through => :day_home_availability_types

  # certification types
  has_many :day_home_certification_types, :dependent => :destroy
  has_many :certification_types, :through => :day_home_certification_types

  has_many :photos, :class_name => 'DayHomePhoto', :dependent => :destroy
  has_many :reviews
  has_many :events

  has_many :user_day_homes, :dependent => :destroy
  has_many :users, :through => :user_day_homes

  #validates :name, :street1, :city, :province, :postal_code, :slug, :email, :phone_number, :highlight, :presence => true
  validates :name,  :postal_code, :slug, :email, :highlight, :presence => true
  validates :highlight,:length => { :maximum => 200 }

  validates_associated :photos
  validates_uniqueness_of :slug #, :email
  validates_format_of :slug, :with => /[a-z0-9]+/
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  accepts_nested_attributes_for :photos, :reject_if => :all_blank, :allow_destroy => true

  # this method is called when creating or updating a dayhome
  # it won't make a call to google maps if we already have a lat long however,
    # this method seems to be ignored on update
  def prevent_geocoding
    (!lat.blank? && !lng.blank?)
  end

  # return a unique string array of availability
  def availability
    avail_type = []

    availability_types.each do |avt|
      avail_type << avt.availability
    end

    avail_type.uniq
  end
  
  def featured_photo
    photos.first
  end
  
  # this method is called when updating the lat long (this is what's fed to google maps)
  def address
    lstreet = "#{street1}#{street2}".blank? ? "" : "#{street1}#{street2},"
	lcity = "#{city}".blank? ? "" : "#{city},"
	
    lstreet+lcity+ ("#{province}".blank? ? "":"#{province},") + "#{postal_code}"
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def assign_availability_type_ids=(availability_type_id_attrs=[])
    self.day_home_availability_types = []
    self.availability_types = AvailabilityType.find_all_by_id(availability_type_id_attrs)
  end
  
  def assign_certification_type_ids=(certification_type_id_attrs=[])
    self.day_home_certification_types = []
    self.certification_types = CertificationType.find_all_by_id(certification_type_id_attrs)
  end
  
  def self.all_for_select
    all.collect {|day_home| [ day_home.name, day_home.id ] }
  end
  
  def self.create_from_signup(signup)
	dayhome = self.new
	dayhome.name = signup.day_home_name
	dayhome.city = signup.day_home_city
	dayhome.province = signup.day_home_province
	dayhome.street1 = signup.day_home_street1
	dayhome.street2 = signup.day_home_street2
	dayhome.postal_code = signup.day_home_postal_code
	dayhome.email = signup.contact_email
	dayhome.slug = signup.day_home_slug
	dayhome.phone_number = signup.day_home_phone_number
	dayhome.blurb = signup.day_home_blurb
	dayhome.highlight = signup.day_home_highlight
	dayhome.featured = false
	dayhome.approved = false
	
	return dayhome
  end
end
