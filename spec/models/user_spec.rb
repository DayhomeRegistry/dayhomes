require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end
  
  [:first_name, :last_name].each do |check|
    it { should validate_presence_of(check) }
  end
  
  describe "full_name" do
    it "should return first + last name" do
      @user.full_name.should == 'John Doe'
    end
  end
  
  describe "day_home_owner?" do
    it "should return true if they have one or more day homes" do
      @day_home = mock_model(DayHome)
      @user.stub!(:day_homes).and_return([@day_home])
      @user.day_home_owner?.should == true
    end
    
    it "should return false if they have no day homes" do
      @user.stub!(:day_homes).and_return([])
      @user.day_home_owner?.should == false
    end
  end
  
  describe "assign_day_home_ids=" do
    it "should find all the day_homes in question and assign them to the user" do
      @day_home = FactoryGirl.build(:day_home)
      DayHome.stub!(:find_all_by_id).and_return([@day_home])
      @user.day_homes.should == []
      @user.assign_day_home_ids = [42]
      @user.day_homes.should == [@day_home]
    end
  end
  
  describe "self.new_from_fb_user" do
    it "should create a new user based on the fb_user objects that come in" do
      SecureRandom.stub!(:hex).and_return('random_password')
      fb_user = { 'first_name' => 'Jim', 'last_name' => 'Doe', 'email' => 'jim@doe.com' }
      fb_access_token = 'token_like'
      fb_expires_in = '123456'
      
      @user = User.new_from_fb_user(fb_user, fb_access_token, fb_expires_in)
      
      @user.first_name.should == 'Jim'
      @user.last_name.should == 'Doe'
      @user.email.should == 'jim@doe.com'
      @user.password.should == 'random_password'
      @user.facebook_access_token.should == 'token_like'
      @user.facebook_access_token_expires_in.should == '123456'
    end
  end
end
