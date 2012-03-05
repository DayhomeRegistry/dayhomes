require 'spec_helper'

describe SearchesController do
  render_views

  before(:each) do
  end

  describe "GET 'index'" do

    describe "success" do
      before(:each) do
        @attr = { :address => "T6L5M6" }
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have a map" do
        get :index, @attr
        response.should have_selector("div.map_container")
      end

      it "should have an address field" do
        get :index
        response.should have_selector("input[name='search[address]'][type='text']")
      end

      it "should have a search button" do
        get :index
        response.should have_selector("input[name='commit'][type='submit']")
      end

      it "should find a valid address" do
        flash[:error].should be_nil
      end

    end

    describe "failure" do
      before(:each) do
        @attr = { :address => "" }
      end

      it "should display 'Address not entered, no search pin dropped'" do
        get :index, :search => @attr
        flash[:error].should == "Address not entered, no search pin dropped"
      end

      it "should display 'Unable to find address, no search pin dropped'" do
        get :index, :search => @attr.merge(:address => "11111111111111111111111111111111111111")
        flash[:error].should == "Unable to find address, no search pin dropped"
      end
    end

  end
end
