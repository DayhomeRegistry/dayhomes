class DayHomeSignupRequestsController < ApplicationController
  def new
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  
  def create
    # Capture the signup request and send email
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])

    # Create user, if necessary
    @user = current_user
    if current_user.nil?
	  #find user by email
	  @user = User.find_by_email(@day_home_signup_request.contact_email)
	  if @user.nil?
	    @user = User.find_by_email(@day_home_signup_request.day_home_email)
	    if @user.nil?
		  #no one here, create a new one
          @user = User.new_from_signup_request(@day_home_signup_request)
          @user.save	  
		end
	  end
    end
            
    # Create a dayhome
    @day_home = DayHome.create_from_signup(@day_home_signup_request)
    @day_home.update_attributes(params[:day_home])
    
    # Bind dayhome to user
    @user.add_day_home(@day_home)
    
	if @day_home.save
	  if @day_home_signup_request.save
        redirect_to root_path, :notice => "Thanks for adding your DayHome! We will contact you soon!"
      else
        render :action => :new
	  end
	else
      render :action => :new
    end
  end
end