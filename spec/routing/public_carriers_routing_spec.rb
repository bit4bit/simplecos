require "spec_helper"

describe PublicCarriersController do
  describe "routing" do

    it "routes to #index" do
      get("/public_carriers").should route_to("public_carriers#index")
    end

    it "routes to #new" do
      get("/public_carriers/new").should route_to("public_carriers#new")
    end

    it "routes to #show" do
      get("/public_carriers/1").should route_to("public_carriers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/public_carriers/1/edit").should route_to("public_carriers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/public_carriers").should route_to("public_carriers#create")
    end

    it "routes to #update" do
      put("/public_carriers/1").should route_to("public_carriers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/public_carriers/1").should route_to("public_carriers#destroy", :id => "1")
    end

  end
end
