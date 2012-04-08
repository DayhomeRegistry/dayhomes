require 'spec_helper'

describe Event do
  before do
    @attr = FactoryGirl.attributes_for(:event)
  end

  it "should create a valid event given valid attributes" do
    valid_event = Event.new(@attr)
    valid_event.should be_valid
  end


end
