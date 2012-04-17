require 'spec_helper'

describe Topic do
  before do
    @category = FactoryGirl.create(:category)
    @forum = FactoryGirl.build(:forum)
    @forum.category = @category
    @topic = FactoryGirl.build(:topic)
    @user = FactoryGirl.create(:user)
    @topic.forum = @forum
    @topic.user = @user
  end

  describe "valid topic" do
    it "should be a valid a topic" do
      @topic.should be_valid
    end
  end

  describe "hits" do
    it "should increase when viewed" do
      @topic.save!
      original_hit = @topic.hits
      @topic.hit!
      after_hit = Topic.find(@topic.id).hits

      original_hit.should be < after_hit
    end
  end

end
