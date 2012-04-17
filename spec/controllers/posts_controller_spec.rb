require 'spec_helper'

describe PostsController do
  render_views

  before(:each) do
    user_attr = FactoryGirl.attributes_for(:user)
    user_attr.delete(:email)
    user_attr.merge(:email => "test123@test.com")
    @user = User.create(user_attr)
    @category = FactoryGirl.create(:category)
    @forum = FactoryGirl.build(:forum)
    @forum.category = @category
    @topic = FactoryGirl.build(:topic)
    @topic.forum = @forum
    @topic.user = @user
    @topic.save!
    @post = FactoryGirl.build(:post)
    @post.forum = @forum
    @post.topic = @topic

    @attr = FactoryGirl.attributes_for(:post)
  end

  describe "dayhome site admin access" do
    before(:each) do
      login_admin_user
      @post.user = @user
      @post.save!
    end

    describe "create" do
      it "should create a post" do
        post :create, :post => @attr, :topic_id => @topic.id
        response.should be_redirect
      end
    end

    describe "update" do
      it "should update a post" do
        put :update, :id => @post.id, :post => @attr
        response.should redirect_to("/topics/#{@topic.id}")
      end
    end

    describe "destroy" do
      it "should delete the post" do
        delete :destroy, :id => @post.id
        response.should redirect_to("/topics/#{@topic.id}")
      end
    end
  end

  describe "dayhome admin access" do
    before(:each) do
      login_day_home_admin_user
      @post.user = @user
      @post.save!
    end

    describe "update" do
      it "should update a post" do
        put :update, :id => @post.id, :post => @attr
        response.should redirect_to("/topics/#{@topic.id}")
      end
    end

    describe "destroy" do
      it "should delete the post" do
        delete :destroy, :id => @post.id
        response.should redirect_to("/topics/#{@topic.id}")
      end
    end
  end

  describe "regular user access" do
    before(:each) do
      login_user
    end

    describe "create" do
      it "should create a post" do
        post :create, :post => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "update" do
      it "should update a post" do
        put :update, :id => @post.id, :post => @attr
        response.should redirect_to(root_path)
      end
    end

    describe "destroy" do
      it "should delete the post" do
        delete :destroy, :id => @post.id
        response.should redirect_to(root_path)
      end
    end
  end

end