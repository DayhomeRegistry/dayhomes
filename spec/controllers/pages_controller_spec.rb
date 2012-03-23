require 'spec_helper'

describe PagesController do
  describe "index" do
    it "should provide a list of featured day homes" do
      @day_home = FactoryGirl.create(:day_home)
      DayHome.stub!(:featured).and_return([@day_home])
      DayHome.should_receive(:featured)
      get :index
    end
  end
end
