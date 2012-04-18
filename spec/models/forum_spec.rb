require 'spec_helper'

describe Forum do
  before (:each) do
    @forum = FactoryGirl.build(:forum)
    @category = FactoryGirl.create(:category)
    @forum.category = @category

  end

  describe "valid forum" do
    it "should be a valid a forum" do
      @forum.should be_valid
    end
  end

end
