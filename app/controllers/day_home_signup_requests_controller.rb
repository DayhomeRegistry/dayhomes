class DayHomeSignupRequestsController < ApplicationController
  def new
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  
  def create
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])
    if @day_home_signup_request.save
      redirect_to root_path, :notice => "Thanks for adding your DayHome! We will contact you soon!"
    else
      render :action => :new
    end
  end
end