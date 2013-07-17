require "spec_helper"

describe TrunksController do
  describe "routing" do

    it "routes to #index" do
      get("/trunks").should route_to("trunks#index")
    end

    it "routes to #new" do
      get("/trunks/new").should route_to("trunks#new")
    end

    it "routes to #show" do
      get("/trunks/1").should route_to("trunks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trunks/1/edit").should route_to("trunks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trunks").should route_to("trunks#create")
    end

    it "routes to #update" do
      put("/trunks/1").should route_to("trunks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trunks/1").should route_to("trunks#destroy", :id => "1")
    end

  end
end
