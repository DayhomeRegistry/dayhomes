require 'spec_helper'

describe DayHome do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:day_home)
  end

  it "should create a dayhome given valid attributes" do
    DayHome.create!(@attr)
  end
  
  describe "validations" do
    [:name, :street1, :city, :province, :postal_code].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end

  describe "geolocation" do
    before(:each) do
      @ryan_house = DayHome.create!(@attr)
    end

    it "should contain a latitude" do
      @ryan_house.lat.should == 53.429691
    end

    it "should contain a longitude" do
      @ryan_house.lng.should == -113.496868
    end

    it "should have a google styled address" do
      @ryan_house.address.should == 'Edmonton, AB, Canada T6W1C3'
    end
  end

end
