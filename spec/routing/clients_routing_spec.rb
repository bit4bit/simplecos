require "spec_helper"

describe ClientsController do
  describe "routing" do

    it "routes to #index" do
      get("/clients").should route_to("clients#index")
    end

    it "routes to #new" do
      get("/clients/new").should route_to("clients#new")
    end

    it "routes to #show" do
      get("/clients/1").should route_to("clients#show", :id => "1")
    end

    it "routes to #edit" do
      get("/clients/1/edit").should route_to("clients#edit", :id => "1")
    end

    it "routes to #create" do
      post("/clients").should route_to("clients#create")
    end

    it "routes to #update" do
      put("/clients/1").should route_to("clients#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/clients/1").should route_to("clients#destroy", :id => "1")
    end

  end
end
