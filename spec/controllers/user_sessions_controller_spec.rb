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
  
  
  describe "fb_connect" do
    it "should redirect to an outh url from FB" do
      koala_client = mock(Koala::Facebook::OAuth)
      koala_client.stub!(:url_for_oauth_code).and_return('some_oath_url_at_fb')
      Koala::Facebook::OAuth.stub!(:new).and_return(koala_client)
      
      Koala::Facebook::OAuth.should_receive(:new).with(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret], 'http://test.host/user_sessions/fb_connect_callback')
      koala_client.should_receive(:url_for_oauth_code).with(:permissions => "email")
      get :fb_connect
      
      response.should redirect_to('some_oath_url_at_fb')
    end
  end
  
  
  
  describe "fb_connect_callback" do
    before(:each) do
      @koala_client = mock(Koala::Facebook::OAuth)
      @koala_client.stub!(:get_access_token_info).and_return({'access_token' => 'super_access_token', 'expires' => '123456'})
      Koala::Facebook::OAuth.stub!(:new).and_return(@koala_client)
      
      @koala_api = mock(Koala::Facebook::OAuth)
      @koala_api.stub!(:get_object).and_return({'email' => 'john@doe.com'})
      Koala::Facebook::API.stub!(:new).and_return(@koala_api)

      @user = FactoryGirl.build(:user)
      @user.stub!(:update_attribute).and_return(true)
      User.stub!(:find_by_email).and_return(@user)
      
      
      @user_session = mock(UserSession)
      @user_session.stub!(:save)
      UserSession.stub!(:new).and_return(@user_session)
    end
    
    def do_render
      get :fb_connect_callback, {:code => 'super_secret_code_in_params'}
    end
    
    it "should initialize the Koala oauth client and get_token_access_info" do
      Koala::Facebook::OAuth.should_receive(:new).with(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret], 'http://test.host/user_sessions/fb_connect_callback')
      @koala_client.should_receive(:get_access_token_info).with('super_secret_code_in_params')
      Koala::Facebook::API.should_receive(:new).with('super_access_token')
      @koala_api.should_receive(:get_object).with('me')
      User.should_receive(:find_by_email).with('john@doe.com')
      
      do_render
    end
    
    describe "existing user" do
      it "should log the user in if they already exist in the system" do
        @user.should_receive(:update_attribute).with(:facebook_access_token, 'super_access_token')
        @user.should_receive(:update_attribute).with(:facebook_access_token_expires_in, '123456')

        UserSession.should_receive(:new).with(@user)
        @user_session.should_receive(:save)
        do_render
      end
    end
    
    describe "new user" do
      before(:each) do
        @new_user = mock_model(User)
        @new_user.stub!(:save).and_return(true)
        User.stub!(:find_by_email).and_return(nil)
        User.stub!(:new_from_fb_user).and_return(@new_user)
      end
      
      it "should create a user from the fb_user" do
        User.should_receive(:new_from_fb_user)
        @new_user.should_receive(:save)
        do_render
      end
      
      it "shoud log the user in if the new_user saves" do
        UserSession.should_receive(:new).with(@new_user)
        @user_session.should_receive(:save)
        do_render
        flash[:error].should be_nil
      end
      
      it "should flash an error message if the new_user doesn't save" do
        @new_user.stub!(:save).and_return(false)
        do_render
        flash[:error].should == 'Someting went wrong while trying to log you in with facebook. Please try again.'
      end
    end
  end
  
end
