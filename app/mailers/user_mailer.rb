class UserMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  def password_reset_instructions(user)
    @user = user
    mail(:to => user.email, :subject => "DayhomeRegistry.com - Password Reset Instructions")
  end
  
  def new_user_password_instructions(user)
    @user = user
    mail(:to => user.email, :subject => "DayhomeRegistry.com - Welcome")
  end

end