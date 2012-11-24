require "spec_helper"

describe ClientCashesController do
  describe "routing" do

    it "routes to #index" do
      get("/client_cashes").should route_to("client_cashes#index")
    end

    it "routes to #new" do
      get("/client_cashes/new").should route_to("client_cashes#new")
    end

    it "routes to #show" do
      get("/client_cashes/1").should route_to("client_cashes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/client_cashes/1/edit").should route_to("client_cashes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/client_cashes").should route_to("client_cashes#create")
    end

    it "routes to #update" do
      put("/client_cashes/1").should route_to("client_cashes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/client_cashes/1").should route_to("client_cashes#destroy", :id => "1")
    end

  end
end
