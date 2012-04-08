require 'spec_helper'

describe EventsController do
  render_views

  before(:each) do
    @event = FactoryGirl.create(:event)
    @attr = FactoryGirl.attributes_for(:event)
    @day_home = FactoryGirl.create(:day_home)
  end

  describe "public user access" do
    describe "index" do
      it "should provide a list of events" do
        get :index, :day_home_id => @day_home.id, :format => :js
        assert_response :success
      end
    end

    describe "show" do
      it "should show a single event" do
        get :show, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response :success
      end
    end

    describe "create" do
      it "should redirect due to no permissions if trying to create an event" do
        post :create, :day_home_id => @day_home.id, :format => :js
        assert_response 302
      end
    end

    describe "update" do
      it "should redirect due to no permissions if trying to create an event" do
        put :update, :day_home_id => @day_home.id, :event => @event, :format => :js
        assert_response 302
      end
    end

    describe "destroy" do
      it "should redirect due to no permissions if trying to delete" do
        delete :destroy, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response 302
      end
    end
  end

  describe "logged in user access" do
    before(:each) do
      login_regular_user
    end

    describe "index" do
      it "should provide a list of events" do
        get :index, :day_home_id => @day_home.id, :format => :js
        assert_response :success
      end
    end

    describe "show" do
      it "should show a single event" do
        get :show, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response :success
      end
    end

    describe "create" do
      it "should redirect due to no permissions if trying to create an event" do
        post :create, :day_home_id => @day_home.id, :event => @attr, :format => :js
        assert_response 302
      end
    end

    describe "update" do
      it "should redirect due to no permissions if trying to create an event" do
        put :update, :day_home_id => @day_home.id, :event => @event, :format => :js
        assert_response 302
      end
    end

    describe "destroy" do
      it "should redirect due to no permissions if trying to delete" do
        delete :destroy, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response 302
      end
    end
  end

  describe "logged in dayhome admin user access" do
    before(:each) do
      login_day_home_admin_user
    end

    describe "index" do
      it "should provide a list of events" do
        get :index, :day_home_id => @day_home.id, :format => :js
        assert_response :success
      end
    end

    describe "show" do
      it "should show a single event" do
        get :show, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response :success
      end
    end

    describe "create" do
      it "should successfully create an event" do
        post :create, :day_home_id => @day_home.id, :event => @attr, :format => :js
        assert_response :success
      end
    end

    describe "update" do
      it "should successfully update an event" do
        @params = { :title => 'test12355'}
        @event.day_home = @day_home
        @event.save!
        put :update, :day_home_id => @day_home.id, :id => @event.id, :event => @params, :format => :js
        assert_response :success
      end
    end

    describe "destroy" do
      it "should delete and event successfully" do
        @event.day_home = @day_home
        @event.save!
        delete :destroy, :day_home_id => @day_home.id, :id => @event.id, :format => :js
        assert_response :success
      end
    end

  end


end
