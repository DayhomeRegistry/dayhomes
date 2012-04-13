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
      @day_home_signup_request = FactoryGirl.build(:day_home_signup_request)
      @day_home_signup_request.stub!(:save)
      DayHomeSignupRequest.stub!(:new).and_return(@day_home_signup_request)
      DayHomeSignupRequest.should_receive(:new).with("some" => "params")
      @day_home_signup_request.should_receive(:save)
      post :create, {:day_home_signup_request => {"some" => "params"}}
    end
  end
end
