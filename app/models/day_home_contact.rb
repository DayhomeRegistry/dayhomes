class DayHomeContact < ActiveRecord::Base
  validates :name, :message, :subject, :day_home_email, :presence => true, :length => { :minimum => 3 }
  
  after_create :send_message_in_email
  
  def send_message_in_email
    DayHomeMailer.contact_day_home(self).deliver
  end
  
end
