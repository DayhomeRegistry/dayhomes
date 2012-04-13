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
end
