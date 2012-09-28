require 'spec_helper'

describe DayHomeSignupRequestsController do
  describe "new" do
    it "should create a new signup request" do
      DayHomeSignupRequest.should_receive(:new)
      get :new
    end
  end
  
  describe "create" do
    it "should create a new dayhome signup request and save it" do
      #build but don't save
      @day_home_signup_request = FactoryGirl.build(:day_home_signup_request)
      @day_home = FactoryGirl.build(:day_home)
      @user = FactoryGirl.build(:user)
      
      #create an empty fake save method on day_home_signup_request
      @day_home_signup_request.stub!(:save)
      
      #create an override new method, and return our FactoryGirl object
      DayHomeSignupRequest.stub!(:new).and_return(@day_home_signup_request)
      DayHome.stub!(:create_from_signup).and_return(@day_home)
      #User.stub!(:find_by_email).with(@day_home_signup_request.contact_email).and_return(@user)
      User.stub!(:find_by_email).and_return(@user)
      
      #setup the expectations.  When we post to the create path on DayHomeSignupRequestController
      # 1) expect a call to User.new_from_signup_request
      User.should_receive(:find_by_email)
      # 2) expect a call to new on DayHome
      DayHome.should_receive(:create_from_signup)
      # 3) expect a new call on DayHomeSignupRequest
      DayHomeSignupRequest.should_receive(:new)
      # 4) expect a save call on DayHomeSignupRequest
      DayHomeSignupRequest.should_receive(:save)
      
      # Now send the post
      post :create, :day_home_signup_request => @day_home_signup_request, :ack => "yes"
    end
  end
end
