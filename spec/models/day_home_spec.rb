require 'spec_helper'

describe DayHome do
  before(:each) do
    @attr = { :name                 => 'Ryan House',
              :address              => 'T6L5M6'}
  end

  it "should create a dayhome given valid attributes" do
    dayhome = DayHome.create!(@attr)
  end

  it "should require a name" do
    DayHome.new(@attr.merge(:name => "")).should_not be_valid
  end

  it "should require a valid address" do
    lambda { DayHome.create!(@attr.merge(:address => "T6L5asdfffffffffffffffffffffffffffM6")) }.should raise_error
  end

  describe "geolocation" do
    before(:each) do
      @ryan_house = DayHome.create!(@attr)
    end

    it "should contain a latitude" do
      @ryan_house.lat.should == 53.47759199999999
    end

    it "should contain a longitude" do
      @ryan_house.lng.should == -113.395897
    end

    it "should have a google styled address" do
      @ryan_house.address.should == 'Edmonton, AB T6L 5M6, Canada'
    end

  end

end
