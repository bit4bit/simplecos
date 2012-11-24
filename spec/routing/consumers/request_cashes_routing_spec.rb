require "spec_helper"

describe Consumers::RequestCashesController do
  describe "routing" do

    it "routes to #index" do
      get("/consumers_request_cashes").should route_to("consumers_request_cashes#index")
    end

    it "routes to #new" do
      get("/consumers_request_cashes/new").should route_to("consumers_request_cashes#new")
    end

    it "routes to #show" do
      get("/consumers_request_cashes/1").should route_to("consumers_request_cashes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/consumers_request_cashes/1/edit").should route_to("consumers_request_cashes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/consumers_request_cashes").should route_to("consumers_request_cashes#create")
    end

    it "routes to #update" do
      put("/consumers_request_cashes/1").should route_to("consumers_request_cashes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/consumers_request_cashes/1").should route_to("consumers_request_cashes#destroy", :id => "1")
    end

  end
end
