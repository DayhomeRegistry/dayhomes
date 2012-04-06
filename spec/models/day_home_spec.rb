require 'spec_helper'

describe DayHome do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:day_home)
  end

  it "should create a dayhome given valid attributes" do
    DayHome.create!(@attr)
  end
  
  describe "validations" do
    [:name, :street1, :city, :province, :postal_code, :slug].each do |attribute|
      it { should validate_presence_of(attribute)}
    end

  end
  
  describe "featured_photo" do
    it "shoud grab the first photo" do
      @day_home = FactoryGirl.create(:day_home)
      @photo1 = FactoryGirl.create(:day_home_photo, :day_home => @day_home)
      @photo2 = FactoryGirl.create(:day_home_photo, :day_home => @day_home)
      @day_home.stub!(:photos).and_return([@photo1, @photo2])
      @day_home.featured_photo.should == @photo1
    end 
  end
  
  describe "to_param" do
    it "should return slug if set otherwise a default" do
      @day_home = FactoryGirl.build(:day_home)
      @day_home.stub!(:id).and_return(42)
      @day_home.to_param.should == '42-awesome-day-home'
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
  
  describe "assign_availability_type_ids=" do
    it "should find all the availability_types in question and assign them to the day_home" do
      @day_home = FactoryGirl.build(:day_home)
      @availability_type = FactoryGirl.build(:availability_type)
      AvailabilityType.stub!(:find_all_by_id).and_return([@availability_type])
      @day_home.availability_types.should == []
      @day_home.assign_availability_type_ids = [42]
      @day_home.availability_types.should == [@availability_type]
    end
  end
  
  describe "assign_certification_type_ids=" do
    it "should find all the certification_types in question and assign them to the day_home" do
      @day_home = FactoryGirl.build(:day_home)
      @certification_type = FactoryGirl.build(:certification_type)
      CertificationType.stub!(:find_all_by_id).and_return([@certification_type])
      @day_home.certification_types.should == []
      @day_home.assign_certification_type_ids = [42]
      @day_home.certification_types.should == [@certification_type]
    end
  end
  
  describe "all_for_select" do
    it "should return a formatted array to be used in a rails select helper" do
      @day_home = FactoryGirl.build(:day_home)
      @day_home.stub!(:id).and_return(42)
      DayHome.stub!(:all).and_return([@day_home])
      DayHome.all_for_select.should == [["Awesome Day Home", 42]]
    end
  end

end
