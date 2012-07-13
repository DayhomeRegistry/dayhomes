class User < ActiveRecord::Base
  acts_as_authentic
  validates_presence_of :first_name, :last_name

  has_many :reviews
  has_many :user_day_homes, :dependent => :destroy
  has_many :day_homes, :through => :user_day_homes

  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
  
  def deliver_password_reset_instructions!
    UserMailer.password_reset_instructions(self).deliver
  end
  
  def day_home_owner?
    day_homes.any?
  end
  
  def assign_day_home_ids=(day_home_id_attrs=[])
    self.user_day_homes = []
    self.day_homes = DayHome.find_all_by_id(day_home_id_attrs)
  end
  
  def add_day_home(day_home)
    self.day_homes<<(day_home)
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
  
end