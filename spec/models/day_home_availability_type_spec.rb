require 'spec_helper'

describe DayHomeAvailabilityType do
  before do
    @dayhome = FactoryGirl.create(:day_home)
    @availability_type = FactoryGirl.create(:availability_type)
  end

  it "should create a dayhome availability type given valid attributes" do
    valid_day_home_availability_type = DayHomeAvailabilityType.new({:day_home_id => @dayhome.id, :availability_type_id => @availability_type.id})
    valid_day_home_availability_type.should be_valid
  end
end
