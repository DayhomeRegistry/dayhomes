
class DayHome < ActiveRecord::Base
  default_scope includes(:photos)
  default_scope includes(:availability_types)
  default_scope includes(:features)
  default_scope where("deleted < 1")
  after_save :clear_cache

  reverse_geocoded_by :lat, :lng
  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => true,
                    :check_process => :prevent_geocoding, :address => :geo_address,
                    :msg => 'Cannot find a location matching that query.' 

  # scopes
  scope :with_availability_uniq, lambda { |default_availability_types|
    joins(:availability_types).
    where("availability_types.availability IN (?) AND availability_types.kind in (?)", default_availability_types[:availability], default_availability_types[:kind]).
    uniq
  }
  scope :featured, lambda {|*args|
    #where(:featured => true)
    joins(:features).where("approved=1").where("end > ?",Time.now()).uniq
  }
  def self.deleted
    DayHome.unscoped.where("deleted = 1")
  end

  # availability types
  has_many :day_home_availability_types, :dependent => :destroy
  has_many :availability_types, :through => :day_home_availability_types

  # certification types
  has_many :day_home_certification_types, :dependent => :destroy
  has_many :certification_types, :through => :day_home_certification_types

  has_many :photos, :class_name => 'DayHomePhoto', :dependent => :destroy
  has_many :reviews
  has_many :events

  # These are going to get removed
  #  has_many :user_day_homes, :dependent => :destroy
  #  has_many :users, :through => :user_day_homes
    
  #  has_many :day_home_agencies, :dependent => :destroy
  #  has_many :agencies, :through => :day_home_agencies
  # to here

  belongs_to :location
  has_one :organization, :through=>:location

  has_many :features, :dependent => :destroy

  #validates :name, :street1, :city, :province, :postal_code, :slug, :email, :phone_number, :highlight, :presence => true
  validates :name,  :postal_code, :slug, :email, :highlight, :presence => true
  validates :highlight,:length => { :maximum => 200 }

  #validates_associated :photos
  validates_uniqueness_of :slug, message: "That web address has already been chosen."
  validates_format_of :slug, :with => /[a-z0-9]+/
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  accepts_nested_attributes_for :photos, :allow_destroy => true #,:reject_if => :all_blank
  
  #before_save :break
  def break
    raise "This is intentionally broken."
  end

  after_save :approval_message
  def approval_message
    #Don't do the checks if this has just been created
    if (!self.id_changed?)
      if (self.approved_changed? && self.approved == true)
        DayHomeMailer.day_home_approval_confirmation(self).deliver
        self.users.each do |user|        
          if (!user.last_login_ip?)  
            UserMailer.new_user_password_reminder(user).deliver
          end
        end
      end
      if (self.approved_changed? && self.approved != true)      
        #DayHomeMailer.day_home_unapproval_confirmation(self).deliver
      end
    end
  end  
  
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
    #debugger
    defaults = photos.where("default_photo=1")
    if (!defaults.empty?)
      @featured_photo ||= defaults.first
    else
      if !photos.empty?
        @featured_photo ||= photos.first
      else
        @featured_photo ||= photos.build
      end
    end
  end

  def featured?
    @featured ||= !self.features.where("end > ?",Time.now()).empty?
  end
  def feature_end_date
    date = self.features.where("end > ?",Time.now()).order("end desc").first
    return date.end unless date.nil?
  end
  def admin_featured=(value)
    if value
      return self.activate(true,1)
    else
      if featured?
        return self.cancel_feature
      end
    end
    return true
  end
  def featured=(value)  
    if value && value != "0"
      return self.activate(false,1)
    else
      if featured?
        return self.cancel_feature
      end
    end
    return true
  end
  def cancel_feature

    self.features.where("end > ?",Time.now()).each do |feature|
      feature.end=Time.now()
      feature.save
    end
  end
  
  # this method is called when updating the lat long (this is what's fed to google maps)
  def geo_address
    "#{street1}#{street2}, #{city}, #{province}, CA, #{postal_code}".gsub(/&/, 'and')+"&components=country:CA" 
  end
  def address
    lstreet = "#{street1}#{street2}".blank? ? "" : "#{street1}#{street2},"
  	lcity = "#{city}".blank? ? "" : " #{city},"
	
    lstreet+lcity+ ("#{province}".blank? ? "":" #{province},") + " #{postal_code}"
    #{}"#{street1}#{street2}, #{city}, #{province}, #{postal_code}"
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
    dayhome.email = signup.day_home_email
    dayhome.slug = signup.day_home_slug
    dayhome.phone_number = signup.day_home_phone_number
    dayhome.blurb = signup.day_home_blurb
    dayhome.highlight = signup.day_home_highlight
    dayhome.featured = false
    dayhome.approved = false
    #dayhome.plan = signup.plan
    
    return dayhome
  end
  def users
    admin_users+locale_users
  end
  def admin_users
    self.organization.users.where("location_id is null")
  end
  def locale_users
    self.organization.users.where("location_id = ?",self.location_id)
  end

  def activate_admin_until(endDate)
    feature = Feature.new();
    feature.day_home=self
    feature.start = Time.now()
    feature.end = endDate
    feature.organization=self.organization
    feature.freebee = false;
    save = feature.save
    return save && self.organization.save
  end
  def activate_admin
    feature = Feature.new();
    feature.day_home=self
    feature.start = Time.now()
    feature.end = Time.now().advance(:months=>1)
    feature.organization=self.organization
    feature.freebee = false;
    save = feature.save
    return save && self.organization.save
  end
  def activate(admin,months)
    saved=true

    @organization = self.organization
    if (admin)
      saved=activate_admin
    else
      #activate a feature
      features = @organization.features
      features = features.where("day_home_id is null")

      last_date = Time.now()
      #check if there are enough credits
      how_many_months = months.to_i
      if(how_many_months<=features.count)
        Feature.transaction do
          how_many_months.times do |f|
            feature = features[f]
            feature.day_home = self
            feature.organization=self.organization
            feature.start = last_date
            last_date = last_date.advance(:months => 1)
            feature.end = last_date
            saved = saved && feature.save
          end
        end
      else
        return false
      end
      return saved
    end
  end

  private
    def clear_cache
      @featured = nil
      @featured_photo = nil
    end
end
