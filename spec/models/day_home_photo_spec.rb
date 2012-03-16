require 'spec_helper'

describe DayHome do
  before(:each) do
    @day_home_photo_attrs = FactoryGirl.attributes_for(:day_home_photo)
  end

  it "should create a photo given valid attributes" do
    DayHomePhoto.create!(@day_home_photo_attrs)
  end
  
end
