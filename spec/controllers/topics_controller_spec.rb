require 'spec_helper'

describe TopicsController do
  render_views

  before(:each) do
    @category = FactoryGirl.create(:category)
    @forum = FactoryGirl.build(:forum)
    @forum.category = @category
    @topic = FactoryGirl.build(:topic)
    @topic.forum = @forum

    @attr = FactoryGirl.attributes_for(:topic)
  end

  describe "dayhome site admin access" do
    before(:each) do
      login_admin_user
      @topic.user = @user
      @topic.save!
    end

    describe "show" do
      it "should show a topic" do
        get :show, :id => @topic.id
        response.should be_success
      end
    end

    describe "create" do
      it "should create a topic" do
        post :create, :topic => @attr, :forum_id => @forum.id
        response.should be_redirect
      end
    end

    describe "update" do
      it "should update a topic" do
        put :update, :id => @topic.id, :topic => @attr
        response.should redirect_to("/topics/#{@topic.id}")
      end
    end

    describe "destroy" do
      it "should delete the topic" do
        delete :destroy, :id => @topic.id
        response.should redirect_to("/forums/#{@forum.id}")
      end
    end
  end

  describe "dayhome admin access" do
    before(:each) do
      login_day_home_admin_user
      @topic.user = @user
      @topic.save!
    end

    describe "show" do
      it "should show a topic" do
        get :show, :id => @topic.id
        response.should be_success
      end
    end

    describe "update" do
      it "should update a topic" do
        put :update, :id => @topic.id, :topic => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the topic" do
        delete :destroy, :id => @topic.id
        response.should redirect_to(root_path)
      end
    end
  end

  describe "regular user access" do
    before(:each) do
      login_user
    end

    describe "show" do
      it "should show a topic" do
        get :show, :id => @topic.id
        response.should redirect_to(root_path)
      end
    end

    describe "create" do
      it "should create a topic" do
        post :create, :topic => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a topic" do
        put :update, :id => @topic.id, :topic => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the topic" do
        delete :destroy, :id => @topic.id
        response.should redirect_to(root_path)
      end
    end
  end

end