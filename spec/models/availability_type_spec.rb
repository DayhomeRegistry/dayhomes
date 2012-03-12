require 'spec_helper'

describe AvailabilityType do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:availability_type)
  end

  it "should create a availability type given valid attributes" do
    valid_availability_type = AvailabilityType.new(@attr)
    valid_availability_type.should be_valid
  end
end
