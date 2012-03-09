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

    it "should not allow dayhomes to have more enrollments than the max enrollments" do
      invalid_enrollment = DayHome.new(@attr.merge(:enrolled => 100, :max_enrollment => 50 ))
      invalid_enrollment.should_not be_valid
    end

    it "should not allow dayhomes to set the max enrollments lower than enrolled" do
      invalid_enrollment = DayHome.new(@attr.merge(:enrolled => 100, :max_enrollment => 50 ))
      invalid_enrollment.should_not be_valid
    end

    it "should not allow dayhomes to have enrolled < 0" do
      invalid_enrollment = DayHome.new(@attr.merge(:enrolled => -1 ))
      invalid_enrollment.should_not be_valid
    end

    it "should not allow dayhomes to have max enrollment < 0" do
      invalid_enrollment = DayHome.new(@attr.merge(:max_enrollment => -1 ))
      invalid_enrollment.should_not be_valid
    end
  end

  describe "default values" do
    before(:each) do
      @ryan_house = DayHome.create!(@attr)
    end

    it "should have an enrollment of 0 if it's not specified" do
      @ryan_house.enrolled.should == 0
    end

    it "should have a maximum enrollment of 10 if it's not specified" do
      @ryan_house.max_enrollment.should == 10
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
