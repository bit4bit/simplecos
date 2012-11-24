require 'spec_helper'

describe ClientCash do

  context "save" do
    fixtures :freeswitches
    fixtures :public_carriers
    fixtures :clients

    it "should increment balance when create cash" do
      client = Client.all.first
      expect {
        cash = ClientCash.new
        cash.client_id = client.id
        cash.amount = 37.0
        cash.save.should be(true)
        client.reload
      }.to change{client.balance}.by(37.0)
    end
  end

  context "update" do
    fixtures :freeswitches
    fixtures :public_carriers
    fixtures :clients
    fixtures :client_cashes

    it "should increment balance" do
      client_cash = ClientCash.create!({:client_id => 1, :amount => 30.0})
      expect{
        client_cash.update_attribute(:amount, 40.0)
      }.to change{client_cash.client.balance}.by(10.0)
    end
    
    it "should decrement balance" do
      client_cash = ClientCash.create!({:client_id => 1, :amount => 30.0})
      expect {
        client_cash.update_attribute(:amount, 20.0)
      }.to change{client_cash.client.balance}.by(-10.0)
    end
  end
  
end
