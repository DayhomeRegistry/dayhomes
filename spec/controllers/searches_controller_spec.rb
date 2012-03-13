require 'spec_helper'

describe SearchesController do
  render_views

  before(:each) do
    login_regular_user
    @attr = FactoryGirl.attributes_for(:search)
  end

  describe "GET 'index'" do
    describe "without query params" do
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

      describe "advanced search form" do
        before(:each) do
          AvailabilityType.create!({:kind => 'Full-time'})
          AvailabilityType.create!({:kind => 'Part-time'})
          AvailabilityType.create!({:kind => 'No Availability'})
        end

        it "should exist" do
          get :index
          response.should have_selector('form', :id => 'advanced-search')
        end

        it "should have advanced search address text box" do
          get :index
          response.should have_selector("form") do |node|
            node.should have_selector('input', :id => 'search_address')
          end
        end

        it "should have availability type checkboxes" do
          get :index
          response.should have_selector("form") do |node|
            node.should have_selector('input', :type => 'checkbox', :value => '1')
            node.should have_selector('input', :type => 'checkbox', :value => '2')
            node.should have_selector('input', :type => 'checkbox', :value => '3')
          end
        end

      end

      it "should get all of the dayhomes" do
        get :index
        flash[:success].should_not be_nil
      end
    end


    describe "with query params" do
      it "should be successful" do
        get :index, @attr
        response.should be_success
      end

      it "should be successful without address" do
        get :index, :search => @attr.merge(:address => "")
        response.should be_success
      end

      it "should be successful with query params" do
        @params = { :advanced_search => true,
                    :address => 'T6L5M6 Edmonton Alberta Canada',
                    :availability_types => { :kind => { :'1' => 1, :'2' => 2, :'3' => 3  } }}

        get :index, :search => @params
        response.should be_success
      end
    end


    describe "failure" do
      it "should display 'Unable to find address, no search pin dropped'" do
        get :index, :search => @attr.merge(:address => "1111111111111111111111asdfasdfasdfasdf1111111111111111fail")
        flash[:error].should_not be_nil
      end
    end

  end
end
