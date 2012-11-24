require 'spec_helper'

describe Client do
  fixtures :freeswitches
  fixtures :public_carriers  

  context "save" do
    it "should save encrypted password" do
      c = Client.new
      c.name = "usuarix"
      c.password = "clave"
      c.password_confirmation = "clave"
      c.public_carrier_id = 1
      c.hashed_password.should_not == "clave"
      c.save.should be_true
    end

    it "shoult authenticated saved client" do
      c = Client.new
      c.name = "usuarix"
      c.password = "clave"
      c.password_confirmation = "clave"
      c.public_carrier_id = 1
      c.save
      Client.authenticate("usuarix", "clave").should_not be_nil
    end
  end

  context "cash" do
    fixtures :clients
    fixtures :client_cashes
    it "should get the total ammount" do
      client = Client.find_by_name('Luis')
      client.total_amount.should eq(100.0)

      client = Client.find_by_name('Pedra')
      client.total_amount.should eq(120.0)
    end
  end
  
end
