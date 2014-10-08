class UserMailer < ActionMailer::Base
  default :from => 'DayHomeRegistry.com <questions@dayhomeregistry.com>'

  # def password_reset_instructions(user)
  #   @user = user
  #   if (Rails.env.development?)
  #     mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "DayhomeRegistry.com - Password Reset Instructions")
  #   else 
  #     mail(:to => user.email, :subject => "DayhomeRegistry.com - Password Reset Instructions")
  #   end
  # end
  
  # def new_user_password_instructions(user)
  #   @user = user
  #   if (Rails.env.development?)
  #     mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "DayhomeRegistry.com - Welcome")
  #   else 
  #     mail(:to => user.email, :subject => "DayhomeRegistry.com - Welcome")
  #   end
  # end
  
  def new_user_password_reminder(user)
    @user = user
    if (Rails.env.development?)
      mail(:to => APPLICATION_CONFIG[:signup_request_to], :subject => "DayhomeRegistry.com - Welcome")
    else 
      mail(:to => user.email, :subject => "DayhomeRegistry.com - Reminder")
    end
  end
end