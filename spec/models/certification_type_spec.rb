require 'spec_helper'

describe CertificationType do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:certification_type)
  end

  it "should create a availability type given valid attributes" do
    valid_availability_type = CertificationType.new(@attr)
    valid_availability_type.should be_valid
  end
end
