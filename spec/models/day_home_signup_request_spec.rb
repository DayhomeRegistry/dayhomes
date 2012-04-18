require 'spec_helper'

describe DayHomeSignupRequest do
  it "should create a dayhome signup request given valid attributes" do
    FactoryGirl.create(:day_home_signup_request)
  end
  
  describe "basic validations" do
    [
      :day_home_name, :day_home_slug, :day_home_city, :day_home_province, :day_home_street1, :day_home_postal_code,
      :day_home_phone_number, :day_home_blurb, :contact_name, :contact_phone_number, :contact_email, :preferred_time_to_contact
    ].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end
end
