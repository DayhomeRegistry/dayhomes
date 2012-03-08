require 'spec_helper'

describe DayHome do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:day_home)
  end
  
  describe "validations" do
    [:name, :street1, :city, :province, :postal_code].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end
  
  it "should create a dayhome given valid attributes" do
    dayhome = DayHome.create!(@attr)
  end

  describe "geolocation" do
    before(:each) do
      @ryan_house = DayHome.create!(@attr)
    end

    it "should contain a latitude" do
      @ryan_house.lat.should == 49.161866
    end

    it "should contain a longitude" do
      @ryan_house.lng.should == -122.324445
    end

    it "should have a google styled address" do
      @ryan_house.address.should == '123 Fake St , Edmonton, AB, Canada V4S 1A4'
    end

  end

end
