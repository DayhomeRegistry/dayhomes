class DayHomeMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def contact_day_home(contact, dayhome)
    @contact = contact
    @dayhome = dayhome
    admin_emails = dayhome.admin_users.map(&:email).join(', ')
    locale_emails = dayhome.locale_users.map(&:email).join(', ')
    emails = dayhome.admin_users+dayhome.locale_users
    to = emails.map(&:email).join(', ')

    if (Rails.env.development?)          
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => contact.subject+"[admin:{"+admin_emails+"}, locale:{"+locale_emails+"}, to:{#{to}}]", :reply_to=>contact.email)
    else  
      mail(:to => to, :subject => contact.subject, :reply_to=>contact.email)
    end
  end

  def referral(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
    mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'A referral to add to the draw for this month') 
  end
  def new_community(organization, community)
    @community = community  
    @organization = organization  
    mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'Someone added a new community') 
  end

  def referral_referrer(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "Thanks for the referral to DayHomeRegistry.com")  
    else 
      mail(:to => to, :subject => "Thanks for the referral to DayHomeRegistry.com", :reply_to=>@day_home_signup_request.referral_email)
    end
  end
  
  def day_home_signup_request(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
	  mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'DayHomeRegistry.com [DayHome Signup Request]')	
  end

  def day_home_upgrade(upgrade)
    @upgrade = upgrade
    mail(:to=> APPLICATION_CONFIG[:signup_request_to], :subject => 'DayHomeRegistry.com [DayHome Upgrade]') 
  end
  
  def day_home_signup_confirmation(day_home_signup_request)
    @day_home_signup_request = day_home_signup_request    
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "We've received your registration at DayHomeRegistry.com")	
    else 
      @dayhome = DayHome.find_by_slug(@day_home_signup_request.day_home_slug)
      @dayhome.admin_users.find do |user|
        mail(:to => user.email, :subject => "We've received your registration at DayHomeRegistry.com")  
      end
      @dayhome.locale_users.find do |user|
        mail(:to => user.email, :subject => "We've received your registration at DayHomeRegistry.com")  
      end
    end
  end
  
  def day_home_approval_confirmation(dayhome)
    @dayhome = dayhome
    
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "You've been approved at DayhomeRegistry.com")
    else 
      @dayhome.admin_users.find do |user|
        mail(:to => user.email, :subject => "You've been approved at DayhomeRegistry.com")
      end
      @dayhome.locale_users.find do |user|
        mail(:to => user.email, :subject => "You've been approved at DayhomeRegistry.com")
      end
    end
    
  end
  def day_home_cancel_notification(organization,too_expensive,no_contact,closed,comments)
    @organization=organization
    @too_expensive=too_expensive
    @no_contact=no_contact
    @closed=closed
    @comments=comments
    mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => 'Cancel Account Notification') 
  end
  def day_home_cancel_confirmation(organization)  
    @organization=organization
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "Cancel Account Confirmation from DayhomeRegistry.com")
    else 
      @dayhome.admin_users.find do |user|
        mail(:to => user.email, :subject => "Cancel Account Confirmation from DayhomeRegistry.com")
      end
      @dayhome.locale_users.find do |user|
        mail(:to => user.email, :subject => "Cancel Account Confirmation from DayhomeRegistry.com")
      end
    end
    
  end
  
end