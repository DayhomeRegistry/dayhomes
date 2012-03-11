require 'spec_helper'

describe "Tasks" do
  describe "GET /searches" do
    it "should display checkboxes" do
      visit searches_path
      response.status.should be(200)

      page.should have_content("Full-time")
    end
  end
end