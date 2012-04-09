class DayHomeContactMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <do-not-reply@dayhomeregistry.com>'

  def contact_day_home(contact)
    @contact = contact
    mail(:to => contact.day_home_email,
         :subject => contact.subject,
         :body => "Name:#{contact.name} \n\nMessage:#{contact.message}")
  end

end