require 'spec_helper'

describe DayHome do
  before(:each) do
    @day_home_photo_attrs = FactoryGirl.attributes_for(:day_home_photo)
  end

  it "should create a photo" do
    @day_home = FactoryGirl.create(:day_home)
    @day_home_photo = DayHomePhoto.create!(@day_home_photo_attrs.merge(:day_home => @day_home))
  end
  
end
