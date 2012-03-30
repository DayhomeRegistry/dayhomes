require 'spec_helper'

describe ReviewsController do
  render_views

  before(:each) do
    login_regular_user
    User.destroy_all
    @user = FactoryGirl.create(:user)
    @day_home = FactoryGirl.create(:day_home)
    @controller.stub(:current_user).and_return(@user)
  end

  describe "create" do
    it "should be successful" do
      @request.env['HTTP_REFERER'] = "http://localhost/day_homes/#{@day_home.id}"

      @params = { :star => 3,
                  :review => {:content => 'T6L5M6 Edmonton Alberta Canada'},
                  :day_home_id => @day_home.id}
      post :create, @params
    end
  end
end
