require 'spec_helper'

describe BillingController do

  describe "GET 'register'" do
    it "returns http success" do
      get 'register'
      response.should be_success
    end
  end

  describe "GET 'upgrade'" do
    it "returns http success" do
      get 'upgrade'
      response.should be_success
    end
  end

end
