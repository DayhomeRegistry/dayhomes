require 'spec_helper'

describe UserAgency do
  before do
    @attr = FactoryGirl.attributes_for(:user_agency)
  end
  
  it "should create a user agency join given valid attributes" do
    UserAgency.create!(@attr)
  end
end
