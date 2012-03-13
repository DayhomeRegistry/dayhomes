require 'spec_helper'

describe Search do
  before(:each) do
    @attr = FactoryGirl.attributes_for(:search)
  end

  it "should create a search model given valid attributes" do
    valid_search = Search.new(@attr.merge(:address => '793 blackburn place edmonton alberta T6W1C3'))
    valid_search.should be_valid
  end

  it "should be valid if all availability types are checked" do
    @params = { :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if 1 availability types is checked" do
    @params = { :availability_types => { :kind => { :'1' => 1 } }}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if submitting from the advanced search form" do
    @params = { :advanced_search => true }

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if all fields are populated" do
    @params = { :advanced_search => true,
                :address => 'T6L5M6 Edmonton Alberta Canada',
                :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  it "should be valid if all fields not populated" do
    @params = { :advanced_search => true,
                :address => ''}

    valid_search = Search.new(@params)
    valid_search.should be_valid
  end

  before(:each) do
    #create pins full/part/no avail and custom searhc pin, test outcome
  end



end
