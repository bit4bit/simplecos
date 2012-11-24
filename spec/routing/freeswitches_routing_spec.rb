require "spec_helper"

describe FreeswitchesController do
  describe "routing" do
    it "routes to #dialplan" do
      post("/dialplan").should route_to("freeswitches#dialplan")
    end
    
    it "routes to #directory" do
      post("/directory").should route_to("freeswitches#directory")
    end
    
    it "routes to #index" do
      get("/freeswitches").should route_to("freeswitches#index")
    end

    it "routes to #new" do
      get("/freeswitches/new").should route_to("freeswitches#new")
    end

    it "routes to #show" do
      get("/freeswitches/1").should route_to("freeswitches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/freeswitches/1/edit").should route_to("freeswitches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/freeswitches").should route_to("freeswitches#create")
    end

    it "routes to #update" do
      put("/freeswitches/1").should route_to("freeswitches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/freeswitches/1").should route_to("freeswitches#destroy", :id => "1")
    end

  end
end
