require 'spec_helper'

describe Agency do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:agency)
  end

  it "should create an agency given valid attributes" do
    Agency.create!(@attr)
  end
  
  describe "basic validations" do
    [
      :name,  :email
    ].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end
  describe "when assigned a user" do
    let(:agency) {FactoryGirl.create(:agency)}
    let(:user) {FactoryGirl.create(:user)}
    
    it "should report one user" do
      agency.add_user(user)
      agency.users.count.should == 1
    end
    it "should have the user report one agency" do
      agency.add_user(user)
      user.agencies.count.should == 1
    end
    it "should have the UserAgency report one" do
      agency.add_user(user)
      UserAgency.all.count.should == 1
    end
  end
  describe "when assigned a user with a dayhome" do
    let(:agency) {FactoryGirl.create(:agency)}
    let(:user) {FactoryGirl.create(:user)}
    let(:dayhome) {FactoryGirl.create(:day_home)}
    
    it "should report raise an error" do
      user.add_day_home(dayhome)
      expect{agency.add_user(user)}.to raise_exception
      #agency.add_user(user)
      agency.users.count.should == 0
    end
  end
  
  describe "when assigned a dayhome" do
    let(:agency) {FactoryGirl.create(:agency)}
    let(:dayhome) {FactoryGirl.create(:day_home)}
  
    it "should report one dayhome" do
      agency.add_day_home(dayhome)
      agency.day_homes.count.should == 1
    end
  end
end
