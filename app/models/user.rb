class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,:rememberable, :trackable, :validatable, 
         :confirmable, :lockable, :timeoutable

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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,:last_name
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
  def self.new_from_fb_user(fb_user, fb_access_token, fb_expires_in)
    random_password = SecureRandom.hex(12)
    new({
      :first_name => fb_user['first_name'],
      :last_name => fb_user['last_name'],
      :email => fb_user['email'],
      :password => random_password,
      :password_confirmation => random_password,
      :facebook_access_token => fb_access_token,
      :facebook_access_token_expires_in => fb_expires_in
    })
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

  protected

    def confirmation_required?
        false
    end
end