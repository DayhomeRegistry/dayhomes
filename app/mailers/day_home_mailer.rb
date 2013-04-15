class DayHomeMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def contact_day_home(contact, dayhome)
    @contact = contact
    @dayhome = dayhome

    if (Rails.env.development?)    
      admin_emails = dayhome.admin_users.map(&:email).join(', ')
      locale_emails = dayhome.locale_users.map(&:email).join(', ')
      emails=dayhome.organization.users.map(&:email).join(', ')
      
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => contact.subject+"[admin:{"+admin_emails+"}, locale:{"+locale_emails+"}]", :reply_to=>contact.email)
    else 
      dayhome.admin_users.find_each do |user|
        mail(:to => user.email, :subject => contact.subject, :reply_to=>contact.email)
      end
      dayhome.locale_users.find_each do |user|
        mail(:to => user.email, :subject => contact.subject, :reply_to=>contact.email)
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
      @dayhome = DayHome.find_by_slug(@day_home_signup_request.day_home_slug)
      @dayhome.admin_users.find_each do |user|
        mail(:to => user.email, :subject => "We've received your registration at DayHomeRegistry.com")  
      end
      @dayhome.locale_users.find_each do |user|
        mail(:to => user.email, :subject => "We've received your registration at DayHomeRegistry.com")  
      end
    end
  end
  
  def day_home_approval_confirmation(dayhome)
    @dayhome = dayhome
    
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "You've been approved at DayhomeRegistry.com")
    else 
      @dayhome.admin_users.find_each do |user|
        mail(:to => user.email, :subject => "You've been approved at DayhomeRegistry.com")
      end
      @dayhome.locale_users.find_each do |user|
        mail(:to => user.email, :subject => "You've been approved at DayhomeRegistry.com")
      end
    end
    
  end
  
end