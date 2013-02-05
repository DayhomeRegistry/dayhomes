class BillingController < ApplicationController
  def signup
    @day_home_signup_request = DayHomeSignupRequest.new
  end
  def register
    @day_home_signup_request = DayHomeSignupRequest.new(params[:day_home_signup_request])   
    raise @day_home_signup_request.to_json()
  end
  def options
  end
  def upgrade
  end
end
