class DayHomeMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def contact_day_home(contact, dayhome)
    @contact = contact
    @dayhome = dayhome

    if (Rails.env.development?)
      if (dayhome.agencies.any?)
        emails=dayhome.organization.users.map(&:email).join(', ')
        
        mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => contact.subject+"["+emails+"]", :reply_to=>contact.email)
      else
        mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => contact.subject+"["+contact.day_home_email+"]", :reply_to=>contact.email)
      end
      
    else 
      if (dayhome.agencies.any?)
        dayhome.organization.users.find_each do |user|
          mail(:to => user.email, :subject => contact.subject, :reply_to=>contact.email)
        end
      else
        mail(:to => contact.day_home_email, :subject => contact.subject, :reply_to=>contact.email)
      end
    end
  end
  
  def day_home_signup_request(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
	  mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'DayHomeRegistry.com [DayHome Signup Request]')	
  end
  
  def day_home_signup_confirmation(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "We've received your registration at DayHomeRegistry.com")	
    else 
      mail(:to => @day_home_signup_request.day_home_email.blank? ? @day_home_signup_request.contact_email : @day_home_signup_request.day_home_email, :subject => "We've received your registration at DayHomeRegistry.com")	
    end
  end
  
  def day_home_approval_confirmation(dayhome)
    @dayhome = dayhome
    @dayhome.users.find_each do |user|
      if (Rails.env.development?)
        mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "You've been approved at DayhomeRegistry.com")
      else 
        mail(:to => user.email, :subject => "You've been approved at DayhomeRegistry.com")
      end
    end
    
  end
  
end