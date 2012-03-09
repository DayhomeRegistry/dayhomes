require 'spec_helper'

describe Admin::UsersController do
  before(:each) do
    @user = mock_model(User)
    login_admin_user
  end
  
  describe "index" do
    def do_render(params={})
      get :index, params
    end
    
    it "should grab all the users in question" do
      User.stub!(:page).and_return([@user])
      User.page.stub!(:per).and_return([@user])
      User.should_receive(:page).with('2')
      User.page.should_receive(:per)
      do_render(:page => '2')
    end
  end
  
  describe "new" do
    def do_render(params={})
      get :new, params
    end
    
    it "should create a new instance of User" do
      User.should_receive(:new)
      do_render
    end
  end
  
  describe "create" do
    before(:each) do
      User.stub!(:new).and_return(@user)
      @user.stub!(:save).and_return(true)
    end
    
    def do_render(params={})
      post :create, params
    end
    
    it "should create a new instance of User" do
      User.should_receive(:new).with("some" => "stuff")
      do_render(:user => {:some => :stuff})
    end
    
    it "should save the day home" do
      @user.should_receive(:save)
      do_render
    end
  end
  
  describe "edit" do
    before(:each) do
      User.stub!(:find).and_return(@user)
    end
    
    def do_render(params={})
      get :edit, {:id => '42'}.merge(params)
    end
    
    it "should find the user in question" do
      User.should_receive(:find).with('42')
      do_render
    end
  end
  
  describe "update" do
    before(:each) do
      User.stub!(:find).and_return(@user)
      @user.stub!(:update_attributes).and_return(true)
    end
    
    def do_render(params={})
      put :update, {:id => '42'}.merge(params)
    end
    
    it "should find the user in question" do
      User.should_receive(:find).with('42')
      do_render
    end
    
    it "should update the user in question" do
      @user.should_receive(:update_attributes).with("some" => "stuff")
      do_render(:user => {:some => :stuff})
    end
  end

  describe "destroy" do
    before(:each) do
      User.stub!(:find).and_return(@user)
      @user.stub(:destroy).and_return(true)
    end
    
    def do_render(params={})
      delete :destroy, {:id => '42'}.merge(params)
    end
    
    it "should find the user in question and destroy it!" do
      User.should_receive(:find).with('42')
      @user.should_receive(:destroy)
      do_render
    end
  end
end
