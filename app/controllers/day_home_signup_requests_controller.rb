class DayHomeSignupRequestsController < ApplicationController
  def index
    redirect_to :action=>:new
  end
  
  def new
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  
  def create
  
    
    #I don't know how to make the checkbox mandatory, so we'll check here first
    if(params["ack"].nil?)
      flash[:error] = "Acknowledging the Privacy Policy and Terms of Use is required."
      return redirect_to :action => :new    
    end
      
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
            
            #but we don't want them to be logged in
            if !current_user_session.nil?
              current_user_session.destroy
            end
        end        
      end
    end
    # Need to set the ack date
    @user.privacy_effective_date = Time.now()
    @user.save
            
    # Create a dayhome
    @day_home = DayHome.create_from_signup(@day_home_signup_request)
    @day_home.update_attributes(params[:day_home])
    
    
    
    
	if @day_home.save
	  if @day_home_signup_request.save
        # Bind dayhome to user
        @user.add_day_home(@day_home)

        #redirect_to root_path, :notice => "Thanks for adding your DayHome! We will contact you soon!"
        return redirect_to :action => :welcome   
    else
      error_msg = []
      @day_home.errors.full_messages.each do |err|
        error_msg << err
      end
      @day_home_signup_request.errors.full_messages.each do |err|
        error_msg << err
      end
      @user.errors.full_messages.each do |err|
        error_msg << err
      end
      flash[:error] = error_msg.join("<br/>").html_safe
      render :action => :new
	  end
	else
      error_msg = []
      @day_home.errors.full_messages.each do |err|
        error_msg << err
      end
      @day_home_signup_request.errors.full_messages.each do |err|
        error_msg << err
      end
      @user.errors.full_messages.each do |err|
        error_msg << err
      end
      flash[:error] = error_msg.join("<br/>").html_safe
      render :action => :new
    end
  end
end

def welcome
end