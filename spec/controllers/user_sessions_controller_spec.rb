require 'spec_helper'

describe UserSessionsController do

  describe "new action" do
    before do
      logout_user
    end

    def do_render
      get :new
    end

    it "should create a new UserSession" do
      UserSession.should_receive(:new)
      do_render
    end

    it "should create a new User" do
      User.should_receive(:new)
      do_render
    end
  end


  describe "create" do
    before do
      logout_user
      @user_session = mock(UserSession)
      @user = FactoryGirl.build(:user)
      @user.stub!(:id).and_return(42)
      @user_session.stub!(:user).and_return(@user)
      @user_session.stub!(:save).and_return(true)
      UserSession.stub!(:new).and_return(@user_session)
    end

    def do_render(params={})
      post :create, params
    end

    it "should create a new UserSession" do
      UserSession.should_receive(:new).with({'a' => 'b'})
      do_render(:user_session => {'a' => 'b'})
    end

    it "should create a new User" do
      User.should_receive(:new)
      do_render
    end

    it "should save the UserSession in question" do
      @user_session.should_receive(:save)
      do_render
    end
  end

  describe "destroy" do
    before do
      login_user
      @user_session = mock(UserSession)
      @user_session.stub!(:destroy)
      @controller.stub!(:current_user_session).and_return(@user_session)
    end

    def do_render
      delete :destroy, {:id => '42'}
    end

    it "should call destroy on the current user session" do
      @user_session.should_receive(:destroy)
      do_render
    end

  end
end
