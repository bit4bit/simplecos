require 'spec_helper'

describe "Freeswitches" do
  describe "GET /freeswitches" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get freeswitches_path
      response.status.should be(200)
    end
  end
  
  describe "GET /bill" do
    fixtures :freeswitches
    fixtures :public_carriers
    fixtures :clients
    fixtures :client_cashes

    it "should GET" do
      get "/bill/1"
      response.status.should be(200)
    end
    
    it "should GET bill from account" do
      
      cash = ClientCash.new
      cash.amount = 35.0
      cash.client_id = 1
      cash.save(:validate => false)

      get "/bill/1"
      response.body.should have_tag("bill", :account => "1") do |bill_tag|
        #@todo ??
        #bill_tag.should eq("35.0")
      end
    end
    
    it "should POST amount to update" do
      client = Client.all.first
      expect {
        post "/bill/1", {:billamount => 10.0, :billaccount => client.id}
        client.reload
      }.to change{ client.balance }.by(-10.0)
    end
    
  end

  describe "POST /dialplan.xml" do
    fixtures :freeswitches 
    fixtures :public_carriers
    fixtures :public_cash_plans

    it "should be ok" do
      post "/dialplan"
      response.status.should be(200)
    end
    
    it "should return fsxml" do
      post "/dialplan.xml", {'FreeSWITCH-IPv4' => '127.0.0.1'}
    end
    
  end
  
  describe "POST /configuration.xml" do
    fixtures :freeswitches 
    fixtures :public_carriers

    it "should be ok" do
      post "/configuration"
      response.status.should be(200)
    end

    context "configuration nibblebill_curl.conf" do
      
      it "should be ok" do
        post "/configuration", {:section => 'configuration', :key_value => 'nibblebill_curl.conf'}
        response.status.should be(200)
      end

      it "should return xml" do
        post "/configuration", {:section => 'configuration', :key_value => 'nibblebill_curl.conf'}
        response.body.should have_tag("configuration", :name => "nibblebill_curl.conf") do |cfg|
          cfg.should have_tag("settings") do |settings|
            settings.should have_tag("param", :name => 'url_lookup', :value => 'http://www.example.com/bill//${nibble_account}')
            settings.should have_tag("param", :name => 'url_save', :value => 'http://www.example.com/bill//${nibble_account}')
          end
        end
      end
      
    end
  end
  
  describe "POST /directory.xml" do
    fixtures :freeswitches
    fixtures :public_carriers
    it "should return xml" do
      post "/directory.xml"
      response.status.should be(200)
    end
    
    it "should return not response" do
      post "/directory.xml"
      response.should have_tag("result", :status => "not found")
    end
    
    it "should return gateway" do
      post "/directory.xml", {'FreeSWITCH-IPv4' => '127.0.0.1', 'purpose' => 'gateways', 'profile'=>'external'}
      #print response.body
      Freeswitch.find_by_ip('127.0.0.1').public_carriers.each{|cr|
        response.body.should have_tag("gateway", :name => cr.name) do |gateway|
          gateway.should have_tag('param',:name => "password", :value => cr.sip_pass.to_s)
          gateway.should have_tag('param',:name => "username", :value => cr.sip_user.to_s)
          gateway.should have_tag('param',:name => "realm", :value => cr.ip.to_s)
          gateway.should have_tag('param',:name => "register", :value => cr.authenticate.to_s)
        end
      }
    end
    
  end

  describe "POTS /xml_cdr" do
    it "should be ok" do
      post xml_cdr_path
      response.status.should be(200)
    end
  end

end
