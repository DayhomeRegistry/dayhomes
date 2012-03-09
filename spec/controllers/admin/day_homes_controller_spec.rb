require 'spec_helper'

describe Admin::DayHomesController do
  before(:each) do
    @day_home = mock_model(DayHome)
    login_admin_user
  end
  
  
  describe "index" do
    def do_render(params={})
      get :index, params
    end
    
    it "should grab all the dayhomes in question" do
      DayHome.stub!(:page).and_return([@day_home])
      DayHome.page.stub!(:per).and_return([@day_home])
      DayHome.should_receive(:page).with('2')
      DayHome.page.should_receive(:per)
      do_render(:page => '2')
    end
  end
  
  describe "new" do
    def do_render(params={})
      get :new, params
    end
    
    it "should create a new instance of DayHome" do
      DayHome.should_receive(:new)
      do_render
    end
  end
  
  describe "create" do
    before(:each) do
      DayHome.stub!(:new).and_return(@day_home)
      @day_home.stub!(:save).and_return(true)
    end
    
    def do_render(params={})
      post :create, params
    end
    
    it "should create a new instance of DayHome" do
      DayHome.should_receive(:new).with("some" => "stuff")
      do_render(:day_home => {:some => :stuff})
    end
    
    it "should save the day home" do
      @day_home.should_receive(:save)
      do_render
    end
  end
  
  describe "edit" do
    before(:each) do
      DayHome.stub!(:find).and_return(@day_home)
    end
    
    def do_render(params={})
      get :edit, {:id => '42'}.merge(params)
    end
    
    it "should find the dayhome in question" do
      DayHome.should_receive(:find).with('42')
      do_render
    end
  end
  
  describe "update" do
    before(:each) do
      DayHome.stub!(:find).and_return(@day_home)
      @day_home.stub!(:update_attributes).and_return(true)
    end
    
    def do_render(params={})
      put :update, {:id => '42'}.merge(params)
    end
    
    it "should find the dayhome in question" do
      DayHome.should_receive(:find).with('42')
      do_render
    end
    
    it "should update the dayhome in question" do
      @day_home.should_receive(:update_attributes).with("some" => "stuff")
      do_render(:day_home => {:some => :stuff})
    end
  end

  describe "destroy" do
    before(:each) do
      DayHome.stub!(:find).and_return(@day_home)
      @day_home.stub(:destroy).and_return(true)
    end
    
    def do_render(params={})
      delete :destroy, {:id => '42'}.merge(params)
    end
    
    it "should find the dayhome in question and destroy it!" do
      DayHome.should_receive(:find).with('42')
      @day_home.should_receive(:destroy)
      do_render
    end
  end
end
