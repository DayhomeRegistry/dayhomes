require 'spec_helper'

describe UserDayHome do
  before do
    @attr = FactoryGirl.attributes_for(:user_day_home)
  end
  
  it "should create a user dayhome join given valid attributes" do
    UserDayHome.create!(@attr)
  end
end
