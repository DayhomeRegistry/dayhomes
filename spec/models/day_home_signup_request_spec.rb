require 'spec_helper'

describe DayHomeSignupRequest do
  it "should create a dayhome signup request given valid attributes" do
    FactoryGirl.create(:day_home_signup_request)
  end
  
  describe "basic validations" do
    [
      :day_home_name,  :day_home_postal_code, :day_home_slug, :day_home_highlight
    ].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end
    
  context "that has a contact phone number" do
    it "should not validate contact email" do
      should_not validate_presence_of(:contact_email)  
    end
  end 
  
  context "that does not have a contact phone number" do
    it "should validate contact email" do
      withEmail = FactoryGirl.create(:day_home_signup_request, day_home_phone_number: nil,contact_email:'email@dayhomeregistry.com')
      withEmail.should_not validate_presence_of(:contact_email)  
    end
  end 
  
  
end
