class DayHomeSignupRequestsController < ApplicationController
  def new
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  
  def create
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])
    @day_home = DayHome.create_from_signup(@day_home_signup_request)
    @day_home.update_attributes(params[:day_home])
	#@day_home.licensed=params['day_home[licensed]']
	#@day_home.licensed=params['dayhome[dietary_accommodations]']
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