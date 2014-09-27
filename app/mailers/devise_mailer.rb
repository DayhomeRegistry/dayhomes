class DeviseMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  def confirmation_instructions(record, token, opts={})
  	debugger
  	if (Rails.env.development?)    
  		opts[:to]=APPLICATION_CONFIG[:signup_request_to]
  	end
    super
  end

  def reset_password_instructions(record, token, opts={})
  	if (Rails.env.development?)    
  		opts[:to]=APPLICATION_CONFIG[:signup_request_to]
  	end
    super
  end

  def unlock_instructions(record, token, opts={})
  	if (Rails.env.development?)    
  		opts[:to]=APPLICATION_CONFIG[:signup_request_to]
  	end
    super
  end
end