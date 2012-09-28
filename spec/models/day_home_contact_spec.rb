require 'spec_helper'

describe DayHomeContact do
  it "should create a dayhome contact" do
    day_home = FactoryGirl.create(:day_home)
    FactoryGirl.create(:day_home_contact, :day_home_id=>day_home.id)
  end
  
  describe "validations" do
    [:name, :message, :subject, :day_home_email].each do |attribute|
      it { should validate_presence_of(attribute)}
    end
  end
  
end
