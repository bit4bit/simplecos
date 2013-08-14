require "spec_helper"

describe SipClientsController do
  describe "routing" do

    it "routes to #index" do
      get("/sip_clients").should route_to("sip_clients#index")
    end

    it "routes to #new" do
      get("/sip_clients/new").should route_to("sip_clients#new")
    end

    it "routes to #show" do
      get("/sip_clients/1").should route_to("sip_clients#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sip_clients/1/edit").should route_to("sip_clients#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sip_clients").should route_to("sip_clients#create")
    end

    it "routes to #update" do
      put("/sip_clients/1").should route_to("sip_clients#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sip_clients/1").should route_to("sip_clients#destroy", :id => "1")
    end

  end
end
