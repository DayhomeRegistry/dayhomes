require 'spec_helper'

describe Search do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:search)
  end

  it "should create a search model given valid attributes" do
    valid_search = Search.new(@attr)
    valid_search.should be_valid
  end

end
