require "spec_helper"

describe Admin::AgenciesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin_agencies").should route_to("admin_agencies#index")
    end

    it "routes to #new" do
      get("/admin_agencies/new").should route_to("admin_agencies#new")
    end

    it "routes to #show" do
      get("/admin_agencies/1").should route_to("admin_agencies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin_agencies/1/edit").should route_to("admin_agencies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin_agencies").should route_to("admin_agencies#create")
    end

    it "routes to #update" do
      put("/admin_agencies/1").should route_to("admin_agencies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin_agencies/1").should route_to("admin_agencies#destroy", :id => "1")
    end

  end
end
