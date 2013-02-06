require "spec_helper"

describe ClientCashPlansController do
  describe "routing" do

    it "routes to #index" do
      get("/client_cash_plans").should route_to("client_cash_plans#index")
    end

    it "routes to #new" do
      get("/client_cash_plans/new").should route_to("client_cash_plans#new")
    end

    it "routes to #show" do
      get("/client_cash_plans/1").should route_to("client_cash_plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/client_cash_plans/1/edit").should route_to("client_cash_plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/client_cash_plans").should route_to("client_cash_plans#create")
    end

    it "routes to #update" do
      put("/client_cash_plans/1").should route_to("client_cash_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/client_cash_plans/1").should route_to("client_cash_plans#destroy", :id => "1")
    end

  end
end
