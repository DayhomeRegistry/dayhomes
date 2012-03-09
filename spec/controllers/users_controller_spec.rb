require 'spec_helper'

describe UsersController do
  describe "new" do
    before(:each) do
      logout_user
    end
    
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
      logout_user
      @user = FactoryGirl.build(:user)
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
      @user = mock_model(User)
      login_user
      @controller.stub(:current_user).and_return(@user)
    end
    
    def do_render(params={})
      get :show, {:id => '42'}.merge(params)
    end
    
    it "should find the user in question" do
      do_render
    end
  end
  
  describe "edit" do
    before(:each) do
      @user = mock_model(User)
      login_user
      @controller.stub(:current_user).and_return(@user)
    end
    
    def do_render(params={})
      get :edit, {:id => '42'}.merge(params)
    end
    
    it "should find the user in question" do
      do_render
    end
  end
  
  describe "update" do
    before(:each) do
      @user = mock_model(User)
      login_user
      @controller.stub(:current_user).and_return(@user)
    end
    
    def do_render(params={})
      put :update, {:id => '42'}.merge(params)
    end

    it "should update the user in question" do
      @user.should_receive(:update_attributes).with("some" => "stuff")
      do_render(:user => {:some => :stuff})
    end
  end

end
