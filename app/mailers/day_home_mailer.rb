class DayHomeMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <do-not-reply@dayhomeregistry.com>'

  def contact_day_home(contact)
    @contact = contact
    mail(:to => contact.day_home_email, :subject => contact.subject, :reply_to=>contact.email)
  end
  
  def day_home_signup_request(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request
    #mail(:to => 'team@dayhomeregistry.com', :subject => 'DayHomeRegistry.com [DayHome Signup Request]')
	mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'DayHomeRegistry.com [DayHome Signup Request]')	
  end

end