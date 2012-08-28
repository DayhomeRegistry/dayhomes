class DayHomeMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def contact_day_home(contact, dayhome)
    @contact = contact
    @dayhome = dayhome
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => contact.subject, :reply_to=>contact.email)
    else 
      mail(:to => contact.day_home_email, :subject => contact.subject, :reply_to=>contact.email)
    end
  end
  
  def day_home_signup_request(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request
    #mail(:to => 'team@dayhomeregistry.com', :subject => 'DayHomeRegistry.com [DayHome Signup Request]')
	  mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'DayHomeRegistry.com [DayHome Signup Request]')	
  end
  
  def day_home_signup_confirmation(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
	  mail(:to => @day_home_signup_request.day_home_email.blank? ? @day_home_signup_request.contact_email : @day_home_signup_request.day_home_email, :subject => "We've received your registration at DayHomeRegistry.com")	
  end
end