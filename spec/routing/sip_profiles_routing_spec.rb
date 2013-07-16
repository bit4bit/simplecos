require "spec_helper"

describe SipProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/sip_profiles").should route_to("sip_profiles#index")
    end

    it "routes to #new" do
      get("/sip_profiles/new").should route_to("sip_profiles#new")
    end

    it "routes to #show" do
      get("/sip_profiles/1").should route_to("sip_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sip_profiles/1/edit").should route_to("sip_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sip_profiles").should route_to("sip_profiles#create")
    end

    it "routes to #update" do
      put("/sip_profiles/1").should route_to("sip_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sip_profiles/1").should route_to("sip_profiles#destroy", :id => "1")
    end

  end
end
