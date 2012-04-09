require 'spec_helper'

describe Event do
  before do
    @attr = FactoryGirl.attributes_for(:event)
    @day_home = FactoryGirl.create(:day_home)
    @attr.merge!({:day_home_id => @day_home.id })
  end

  it "should create a valid event given valid attributes" do
    valid_event = Event.new(@attr)
    valid_event.should be_valid
  end

  it "should be invalid if ends_at < starts_at" do
    valid_event = Event.new(@attr.merge(:ends_at => DateTime.now - 10))
    valid_event.should_not be_valid
  end

  it "should be invalid if ends_at < starts_at" do
    valid_event = Event.new(@attr.merge(:ends_at => DateTime.now - 10))
    valid_event.should_not be_valid
  end

  it "should be invalid if no title" do
    @attr.delete(:title)
    valid_event = Event.new(@attr)
    valid_event.should_not be_valid
  end

  it "should be invalid if no starts_dt" do
    @attr.delete(:starts_at)
    valid_event = Event.new(@attr)
    valid_event.should_not be_valid
  end

  it "should be invalid if no ends_at" do
    @attr.delete(:ends_at)
    valid_event = Event.new(@attr)
    valid_event.should_not be_valid
  end


end
