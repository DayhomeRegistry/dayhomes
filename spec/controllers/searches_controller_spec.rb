require 'spec_helper'

describe SearchesController do
  render_views

  before(:each) do
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have an address field" do
      get :new
      response.should have_selector("input[name='search[address]'][type='text']")
    end

    it "should have a search button" do
      get :new
      response.should have_selector("input[name='commit'][type='submit']")
    end
  end

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = { :address => "" }
      end

      it "should render the 'new' page" do
        post :create, :search => @attr
        response.should render_template('new')
      end

      it "should have model errors" do
        post :create, :search => @attr
        response.should have_selector("div.field_with_errors")
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :address => "T6L5M6" }
      end

      it "should redirect to the user index page" do
        post :create, :search => @attr
        response.should redirect_to('/searches?address=T6L5M6')
      end
    end
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
    end

    describe "failure" do
      before(:each) do
        @attr = { :address => "" }
      end

      it "should render the 'new' page" do
        get :index, :search => @attr
        response.should render_template("new")
      end

    end

  end
end
