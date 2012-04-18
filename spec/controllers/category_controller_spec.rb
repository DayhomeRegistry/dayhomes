require 'spec_helper'

describe CategoriesController do
render_views

  before(:each) do
    @category = FactoryGirl.create(:category)
    @attr = FactoryGirl.attributes_for(:category)
  end

  describe "dayhome site admin access" do
    before(:each) do
      login_admin_user
    end

    describe "index" do
      it "should provide a list of categories" do
        get :index
        assert_response :success
      end
    end

    describe "create" do
      it "should create a category" do
        post :create, :category => @attr
        response.should redirect_to(forums_url)
      end
    end

    describe "update" do
      it "should update a category" do
        put :update, :id => @category.id, :category => @attr
        response.should redirect_to(forums_url)
      end
    end

    describe "destroy" do
      it "should delete the category" do
        delete :destroy, :id => @category.id
        response.should redirect_to(forums_url)
      end
    end
  end

  describe "dayhome admin access" do
    before(:each) do
      login_day_home_admin_user
    end

    describe "index" do
      it "should provide a list of categories" do
        get :index
        assert_response :success
      end
    end

    describe "create" do
      it "should create a category" do
        post :create, :category => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a category" do
        put :update, :id => @category.id, :category => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the category" do
        delete :destroy, :id => @category.id
        response.should redirect_to(root_path)
      end
    end
  end

  describe "regular user access" do
    before(:each) do
      login_user
    end

    describe "index" do
      it "should provide a list of categories" do
        get :index
        response.should redirect_to(root_path)
      end
    end

    describe "create" do
      it "should create a category" do
        post :create, :category => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a category" do
        put :update, :id => @category.id, :category => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the category" do
        delete :destroy, :id => @category.id
        response.should redirect_to(root_path)
      end
    end
  end

end