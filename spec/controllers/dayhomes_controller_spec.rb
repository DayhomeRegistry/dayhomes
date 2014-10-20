require 'spec_helper'

describe DayhomesController do

  describe "GET '[new]'" do
    it "returns http success" do
      get '[new]'
      response.should be_success
    end
  end

end
