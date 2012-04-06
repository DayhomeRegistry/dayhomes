require 'spec_helper'

describe AvailabilityType do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:availability_type)
  end
  
  [:kind, :availability].each do |check|
    it { should validate_presence_of(check) }
  end
  it "should create a availability type given valid attributes" do
    valid_availability_type = AvailabilityType.new(@attr)
    valid_availability_type.should be_valid
  end
end
