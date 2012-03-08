require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.build(:user)
  end
  
  [:first_name, :last_name].each do |check|
    it { should validate_presence_of(check) }
  end
  
  describe "full_name" do
    it "should return first + last name" do
      @user.full_name.should == 'John Doe'
    end
  end
end
