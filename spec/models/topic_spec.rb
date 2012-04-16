require 'spec_helper'

describe Topic do
  before do
    @topic = FactoryGirl.build(:topic)
    @forum = FactoryGirl.build(:forum)
    @user = FactoryGirl.build(:user)
    @post = FactoryGirl.build(:post)
    @topic.forum = @forum
    @topic.user = @user
  end

  describe "valid topic" do
    it "should be a valid a topic" do
      @topic.should be_valid
    end
  end

end
