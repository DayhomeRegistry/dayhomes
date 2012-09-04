class DayHomeContact < ActiveRecord::Base
  validates :name, :message, :subject, :email, :day_home_email, :presence => true, :length => { :minimum => 3 }
  
  after_create :send_message_in_email
  
  def send_message_in_email
    @dayhome = DayHome.find(self.day_home_id)
    DayHomeMailer.contact_day_home(self,@dayhome).deliver
  end
  
end
