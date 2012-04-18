require 'spec_helper'

describe Category do
  before do (:each)
    @category = FactoryGirl.build(:category)
  end

  describe "valid category" do
    it "should be a valid a category" do
      @category.should be_valid
    end
  end

end
