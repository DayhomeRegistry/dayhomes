require 'spec_helper'

describe ForumsController do
  render_views

  before(:each) do
    @forum = FactoryGirl.build(:forum)
    @category = FactoryGirl.create(:category)
    @forum.category = @category
    @forum.save!

    @attr = FactoryGirl.attributes_for(:forum)
  end

  describe "dayhome site admin access" do
    before(:each) do
      login_admin_user
    end

    describe "index" do
      it "should provide a list of forums" do
        get :index
        response.should be_success
      end
    end

    describe "show" do
      it "should show a forum" do
        get :show, :id => @forum.id
        response.should be_success
      end
    end

    describe "create" do
      it "should create a forum" do
        post :create, :forum => @attr
        response.should be_success
      end
    end

    describe "update" do
      it "should update a forum" do
        put :update, :id => @forum.id, :forum => @attr
        response.should redirect_to("/forums/#{@forum.id}")
      end
    end

    describe "destroy" do
      it "should delete the forum" do
        delete :destroy, :id => @forum.id
        response.should redirect_to(forums_url)
      end
    end
  end

  describe "dayhome admin access" do
    before(:each) do
      login_day_home_admin_user
    end

    describe "show" do
      it "should show a forum" do
        get :show, :id => @forum.id
        response.should be_success
      end
    end

    describe "index" do
      it "should provide a list of forums" do
        get :index
        assert_response :success
      end
    end

    describe "create" do
      it "should create a forum" do
        post :create, :forum => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a forum" do
        put :update, :id => @forum.id, :forum => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the forum" do
        delete :destroy, :id => @forum.id
        response.should redirect_to(root_path)
      end
    end
  end

  describe "regular user access" do
    before(:each) do
      login_user
    end

    describe "index" do
      it "should provide a list of forums" do
        get :index
        response.should redirect_to(root_path)
      end
    end

    describe "show" do
      it "should show a forum" do
        get :show, :id => @forum.id
        response.should redirect_to(root_path)
      end
    end

    describe "create" do
      it "should create a forum" do
        post :create, :forum => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a forum" do
        put :update, :id => @forum.id, :forum => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the forum" do
        delete :destroy, :id => @forum.id
        response.should redirect_to(root_path)
      end
    end
  end

end