require 'spec_helper'

describe PagesController do
  describe "index" do
    it "should pick a random featured dayhome to display" do
      @day_home = FactoryGirl.create(:day_home)
      DayHome.stub!(:featured).and_return([@day_home])
      DayHome.should_receive(:featured)
      get :index
    end
  end
  
  describe "about" do
    it "should render an about page" do
      get :about
    end
  end
  
end
