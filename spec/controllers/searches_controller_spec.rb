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



end
