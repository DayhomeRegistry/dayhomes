require 'spec_helper'

describe DayHome do
  before(:each) do
    @attr = { :name                 => 'Ryan House',
              :address              => 'T6L5M6'}
  end

  it "should create a dayhome given valid attributes" do
    dayhome = DayHome.create!(@attr)
  end

  it "should require a name" do
    DayHome.new(@attr.merge(:name => "")).should_not be_valid
  end

end
