require 'spec_helper'

describe PagesController do
  describe "index" do
    it "should pick a random featured dayhome to display" do
      @day_home = FactoryGirl.create(:day_home)
      DayHome.stub!(:featured).and_return([@day_home])
      DayHome.featured.stub!(:offset).and_return(@day_home)
      DayHome.featured.stub!(:count).and_return(5)
      DayHome.featured.stub!(:first).and_return(@day_home)
      @controller.stub!(:rand).and_return(2)
      @controller.should_receive(:rand).with(5)
      DayHome.should_receive(:featured)
      DayHome.featured.should_receive(:count)
      DayHome.featured.should_receive(:first).with({:offset => 2})
      get :index
    end
  end
  
  describe "about" do
    it "should render an about page" do
      get :about
    end
  end
  
end
