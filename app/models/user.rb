class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable,:rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :timeoutable, :omniauthable, :omniauth_providers => [:facebook]

  alias :devise_valid_password? :valid_password?

  def valid_password?(password)
    begin
      super(password)
    rescue BCrypt::Errors::InvalidHash
      debugger
      digest=password+self.password_salt
      20.times{digest=Digest::SHA512.hexdigest(digest)}
      return false unless  digest == encrypted_password
      logger.info "User #{email} is using the old password hashing method, updating attribute."
      self.password = password
      true
    end
  end
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,:last_name, :provider, :uid
  #acts_as_authentic
  #validates_presence_of :first_name, :last_name

  has_many :reviews
  has_many :user_day_homes, :dependent => :destroy
  has_many :day_homes, :through => :user_day_homes
  
  has_many :user_agencies, :dependent => :destroy
  has_many :agencies, :through => :user_agencies

  
  belongs_to :organization
  belongs_to :location

  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy


  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def deliver_password_reset_instructions!
    UserMailer.password_reset_instructions(self).deliver
  end
  
  def day_home_owner?
    organization.any?
    #day_homes.any? 
  end
  def organization_admin?
    !organization.nil?
  end  
  
  def assign_day_home_ids=(day_home_id_attrs=[])
    self.user_day_homes = []
    self.day_homes = DayHome.find_all_by_id(day_home_id_attrs)
  end
  def self.all_for_select
    all.collect {|user| [ user.full_name, user.id ] }
  end
  def self.unassigned_for_select
    User.find(:all, :include => "user_day_homes", :conditions => ["user_day_homes.day_home_id IS NULL"]).collect {|user| [user.full_name,user.id]}
  end
  def add_day_home(day_home)
    if (self.agencies.count != 0) then
      raise "A user can't have an agency and a dayhome"
    end
    self.day_homes<<(day_home)
  end
  def add_agency(agency)
    if (self.day_homes.count != 0) then
      raise "A user can't have an agency and a dayhome"
    end
    self.agencies<<(agency)
  end    
  def self.new_from_signup_request(signup_request)
    random_password = SecureRandom.hex(12)
    new({
      :first_name => signup_request.first_name,
      :last_name => signup_request.last_name,
      :email => signup_request.contact_email ,    
      :password => random_password,
      :password_confirmation => random_password
    })
  end

  #Omniauth stuff
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create
    if(!user.persisted?)
      by_email = where(email: auth.info.email).first
      if(!by_email.nil?)
        user = by_email
    
        #we need to update the tokens
        user.provider="facebook"
        user.uid=auth.uid
        user.save(:validate => false)   
      else  
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.first_name = auth.info.first_name   # assuming the user model has a name
        user.last_name = auth.info.last_name # assuming the user model has an image
      end
    end
    return user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  protected

    def confirmation_required?
        false
    end
end