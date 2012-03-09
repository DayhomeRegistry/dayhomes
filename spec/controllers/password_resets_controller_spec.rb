require 'spec_helper'

describe PasswordResetsController do

  describe "new action" do
    def do_render(params={})
      get :new, params
    end

    it "should be a success" do
      do_render
      response.should be_success
    end
  end

  describe "create action" do
    before do
      @user = FactoryGirl.build(:user)
      @user.stub!(:deliver_password_reset_instructions!)
      User.stub!(:find_by_email).and_return(@user)
    end

    def do_render(params={})
      post :create, params
    end

    it "should find the user by the email provided" do
      User.should_receive(:find_by_email).with("john@doe.com")
      do_render(:email => 'john@doe.com')
    end

    describe "if a user is found" do
      it "deliver_password_reset_instructions if a matching user is found" do
        @user.should_receive(:deliver_password_reset_instructions!)
        do_render
      end
    end

    describe "if a user is not found" do
      it "deliver_password_reset_instructions if a matching user is found" do
        User.stub!(:find_by_email).and_return(nil)
        @user.should_not_receive(:deliver_password_reset_instructions!)
        do_render
      end
    end
  end

  describe "edit action" do
    def do_render(params={})
      get :edit, params
    end

    it "should try to find the matching user via the perishable token" do
      @user = FactoryGirl.build(:user)
      User.stub!(:find_by_single_access_token).and_return(@user)
      User.should_receive(:find_by_single_access_token).with("42")
      do_render(:id => '42')
    end
  end


  describe "update action" do
    def do_render(params={})
      put :update, {:id => '42', :user => {:password => '123456', :password_confirmation => '123456'}}.merge(params)
    end

    before do
      logout_user
      @user = FactoryGirl.build(:user)
      @user.stub!(:id).and_return('42')
      @user_session = mock(UserSession)
      @user_session.stub!(:save).and_return(true)
      @user.stub!(:save).and_return(true)
      @user.stub!(:password=)
      @user.stub!(:password_confirmation=)
      UserSession.stub!(:new).and_return(@user_session)
      User.stub!(:find_by_single_access_token).and_return(@user)
    end

    it "should try to find the matching user via the perishable token" do
      User.should_receive(:find_by_single_access_token).with("42")
      do_render(:id => '42')
    end

    it "should update the password" do
      @user.should_receive(:password=).with("123456")
      @user.should_receive(:password_confirmation=).with("123456")
      do_render
    end

  end


end
