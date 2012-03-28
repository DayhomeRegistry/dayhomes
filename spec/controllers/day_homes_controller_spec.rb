require 'spec_helper'

describe DayHomesController do
  describe "new" do
    def do_render(params={})
      get :show, {:id => '42'}.merge(params)
    end
    
    it "should create a find the day home in question" do
      @day_home = FactoryGirl.build(:day_home)
      DayHome.stub!(:find).and_return(@day_home)
      DayHome.should_receive(:find).with('42').and_return(@day_home)
      do_render
    end
  end



end