require 'spec_helper'

describe DayHomesController do
  describe "show" do
    before(:each) do
      @day_home = FactoryGirl.build(:day_home)
    end
    
    it "should attempt to find the the dayhome by set slug" do
      DayHome.stub!(:find_by_slug).and_return(@day_home)
      DayHome.should_receive(:find_by_slug).with('dayhome_test').and_return(@day_home)
      get :show, {:slug => 'dayhome_test'}
      response.should be_success
    end
    
    it "should attempt to find the the dayhome by set slug" do
      DayHome.stub!(:find_by_slug).and_return(nil)
      DayHome.stub!(:find_by_id).and_return(@day_home)
      DayHome.should_receive(:find_by_slug).with(nil).and_return(nil)
      DayHome.should_receive(:find_by_id).with('42-fallback-param').and_return(@day_home)
      get :show, {:id => '42-fallback-param'}
      response.should be_success
    end
    
    it "should redirect to a 404 page if no dayhome is found" do
      DayHome.stub!(:find_by_slug).and_return(nil)
      DayHome.stub!(:find_by_id).and_return(nil)
      DayHome.should_receive(:find_by_slug).with('doesnotexist1').and_return(nil)
      DayHome.should_receive(:find_by_id).with('doesnotexist2').and_return(nil)
      get :show, {:slug => 'doesnotexist1', :id => 'doesnotexist2'}
      response.should be_redirect
    end
    
  end
end