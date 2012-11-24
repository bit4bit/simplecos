require "spec_helper"

describe PublicCashPlansController do
  describe "routing" do

    it "routes to #index" do
      get("/public_cash_plans").should route_to("public_cash_plans#index")
    end

    it "routes to #new" do
      get("/public_cash_plans/new").should route_to("public_cash_plans#new")
    end

    it "routes to #show" do
      get("/public_cash_plans/1").should route_to("public_cash_plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/public_cash_plans/1/edit").should route_to("public_cash_plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/public_cash_plans").should route_to("public_cash_plans#create")
    end

    it "routes to #update" do
      put("/public_cash_plans/1").should route_to("public_cash_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/public_cash_plans/1").should route_to("public_cash_plans#destroy", :id => "1")
    end

  end
end
