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
      @user.full_name.should == @user.first_name + " " + @user.last_name
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
  
  describe "all_for_select" do
    it "should return all the users" do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user3.add_day_home(FactoryGirl.create(:day_home))
      @list = User.all_for_select
      @list.should == [[@user1.full_name,@user1.id],[@user2.full_name,@user2.id],[@user3.full_name,@user3.id]]
    end
  end
  describe "unassigned_for_select" do
    it "should return all the users without an assigned dayhome" do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user2.add_day_home(FactoryGirl.create(:day_home))
      @list = User.unassigned_for_select
      @list.should == [[@user1.full_name,@user1.id]]
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
  describe "when assigned an agency" do
    let(:agency) {FactoryGirl.create(:agency)}
    let(:user) {FactoryGirl.create(:user)}
    
    it "should report one user" do
      user.add_agency(agency)
      agency.users.count.should == 1
    end
    it "should have the user report one agency" do
      user.add_agency(agency)
      user.agencies.count.should == 1
    end
    it "should have the UserAgency report one" do
      user.add_agency(agency)
      UserAgency.all.count.should == 1
    end
  end
  describe "when already has a dayhome and is assigned an agency" do
    it "should raise an error" do
      @anotherUser = FactoryGirl.create(:user)
      @day_home = FactoryGirl.create(:day_home)
      @anotherUser.add_day_home(@day_home)
      @anotherUser.day_homes.count.should == 1
      @agency = FactoryGirl.create(:agency)
      expect{@anotherUser.add_agency(@agency)}.to raise_exception
    end
  end
  describe "when already has an agency and is assigned an dayhome" do
    it "should raise an error" do
      @anotherUser = FactoryGirl.create(:user)
      @day_home = FactoryGirl.create(:day_home)
      @agency = FactoryGirl.create(:agency)
      @anotherUser.add_agency(@agency)
      @anotherUser.agencies.count.should == 1
      expect{@anotherUser.add_day_home(@day_home)}.to raise_exception
    end
  end
end
