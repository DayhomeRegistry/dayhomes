class DayHomeSignupRequest < ActiveRecord::Base
  validates_presence_of :day_home_name, :day_home_slug, :day_home_city, :day_home_province, :day_home_street1, :day_home_postal_code
  validates_presence_of :day_home_phone_number, :day_home_blurb, :contact_name, :contact_phone_number, :contact_email
  validates_presence_of :preferred_time_to_contact
  
  after_create :send_request_to_dayhome_registry_team
  
  def send_request_to_dayhome_registry_team
    DayHomeMailer.day_home_signup_request(self).deliver
  end
end