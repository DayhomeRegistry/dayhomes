require 'spec_helper'

describe Review do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @day_home = FactoryGirl.create(:day_home)
    @attr = FactoryGirl.attributes_for(:review)
  end

  describe "success" do
    it "should create a review valid attributes" do
      valid_review = Review.new(@attr.merge(:content => 'I am a review',
                                            :rating => 5))
      valid_review.user = @user
      valid_review.day_home = @day_home
      valid_review.should be_valid
    end
  end

  describe "failure" do
    it "should fail without a user" do
      valid_review = Review.new(@attr.merge(:content => 'I am a review',
                                            :rating => 5))
      valid_review.day_home = @day_home
      valid_review.should_not be_valid
    end

    it "should fail without content" do
      @attr.delete(:content)
      valid_review = Review.new(@attr.merge(:rating => 5))
      valid_review.user = @user
      valid_review.day_home = @day_home
      valid_review.should_not be_valid
    end

    it "should fail with content < 5" do
      valid_review = Review.new(@attr.merge(:content => '123',
                                            :rating => 5))
      valid_review.user = @user
      valid_review.day_home = @day_home
      valid_review.should_not be_valid
    end

    it "should fail with a rating < 1>" do
      valid_review = Review.new(@attr.merge(:content => '123',
                                            :rating => -1))
      valid_review.user = @user
      valid_review.day_home = @day_home
      valid_review.should_not be_valid
    end

    it "should fail with a rating > 5" do
      valid_review = Review.new(@attr.merge(:content => '123',
                                            :rating => 10))
      valid_review.user = @user
      valid_review.day_home = @day_home
      valid_review.should_not be_valid
    end
  end
end
