require 'spec_helper'

describe Post do
  before (:each) do
    @post = FactoryGirl.build(:post)
    @forum = FactoryGirl.build(:forum)
    @user = FactoryGirl.build(:user)
    @topic = FactoryGirl.build(:topic)
    @post.user = @user
    @post.topic = @topic
    @post.forum = @forum
  end

  describe "valid post" do
    it "should be a valid a post" do
      @post.should be_valid
    end
  end
end
