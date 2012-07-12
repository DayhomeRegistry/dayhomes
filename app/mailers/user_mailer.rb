class UserMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def password_reset_instructions(user)
    @user = user
    mail(:to => user.email, :subject => "DayHomeRegistry.com - Password Reset Instructions")
  end

end