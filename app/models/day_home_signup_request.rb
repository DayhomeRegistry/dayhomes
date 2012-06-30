class DayHomeSignupRequest < ActiveRecord::Base
  
  validates :day_home_name,  :day_home_postal_code, :day_home_slug, :day_home_highlight, :presence => true
  validates :day_home_highlight,:length => { :maximum => 200 }
  validates :contact_email, :presence => {:unless => "day_home_phone_number", :message => "You must enter an email, phone number, or both"}
  
  validates_uniqueness_of :day_home_slug
  
  #validates_presence_of :preferred_time_to_contact
  
  #before_save :add_dayhome
  
  after_create :send_request_to_dayhome_registry_team
  
  def send_request_to_dayhome_registry_team
    DayHomeMailer.day_home_signup_request(self).deliver
  end
  def add_dayhome
    @day_home = DayHome.create_from_signup(self)
    @day_home.update_attributes(params[:day_home])
	
	#false should cancel the action
    return @day_home.save     
  end
  
  
  def assign_availability_type_ids=(availability_type_id_attrs=[])
    self.day_home_availability_types = []
    self.availability_types = AvailabilityType.find_all_by_id(availability_type_id_attrs)
  end
  
  def assign_certification_type_ids=(certification_type_id_attrs=[])
    self.day_home_certification_types = []
    self.certification_types = CertificationType.find_all_by_id(certification_type_id_attrs)
  end
end