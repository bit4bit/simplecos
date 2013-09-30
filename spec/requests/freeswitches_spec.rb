require 'spec_helper'

describe "Freeswitches" do
  
  describe "GET /bill" do
    fixtures :freeswitches
    fixtures :public_carriers
    fixtures :clients
    fixtures :client_cashes
    fixtures :sip_clients

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
      print response.body
      response.body.should have_tag("section", "name" => "dialplan") do |section|
        
      end
    end
    

  end
  
  describe "POST /configuration.xml" do
    fixtures :freeswitches 
    fixtures :sip_profiles
    fixtures :public_carriers
    fixtures :trunks

    it "should be ok" do
      post "/configuration"
      response.status.should be(200)
    end

    context "configuration sofia.conf" do
      it "should be ok" do
        post "/configuration", {:section => 'configuration', :key_value => 'sofia.conf'}
        response.body.should have_tag("section") do |section|
          section.should have_tag("result", "status" => "not found")
        end
        
      end
      
      it "should return xml not response" do
        post "/configuration", {:section => 'configuration', :key_value => 'sofia.conf'}
        response.status.should be(200)
      end

      it "should return xml" do
        post "/configuration", {:section => 'configuration', :key_value => 'sofia.conf', 'FreeSWITCH-IPv4' => '127.0.0.1'}
        response.body.should have_tag("profiles")
      end

      it "should return xml with profiles" do
        post "/configuration", {:section => 'configuration', :key_value => 'sofia.conf', 'FreeSWITCH-IPv4' => '127.0.0.1'}

        freeswitch = Freeswitch.find_by_ip('127.0.0.1')
        response.body.should have_tag("profiles") do |profiles|
          freeswitch.sip_profiles.each do |sip_profile|
            profiles.should have_tag("profile", :name => sip_profile.name) do |profile|
              profile.should have_tag("gateways") do |gateways|
                sip_profile.public_carriers.each do |public_carrier|
                  public_carrier.trunks.each do |trunk|
                    gateways.should have_tag("gateway") do |gateway|
                      gateway.should have_tag("param", :name => "username", :value => trunk.sip_user.to_s)
                      gateway.should have_tag("param", :name => "password", :value => trunk.sip_pass.to_s)
                      gateway.should have_tag("param", :name => "realm", :value => trunk.realm)
                    end
                  end
                end
              end
              profile.should have_tag("settings") do |settings|
                settings.should have_tag("param", :name => "sip-port", :value => sip_profile.sip_port.to_s)
                settings.should have_tag("param", :name => "sip-ip", :value => sip_profile.sip_ip.to_s)
                settings.should have_tag("param", :name => "rtp-ip", :value => sip_profile.rtp_ip.to_s)
              end
            end
          end #sip_profile
        end
      end
    end
    
    context "configuration distributor.conf" do

      it "should be ok" do
        post "/configuration", {:section => 'configuration', :key_value => 'distributor.conf'}
        response.status.should be(200)
      end

      it "should return xml" do
        post "/configuration", {:section => 'configuration', :key_value => 'distributor.conf'}
        response.status.should be(200)
        response.body.should have_tag("lists")

      end

      it "should return xml with nodes" do
        post "/configuration", {:section => 'configuration', :key_value => 'distributor.conf'}
        response.body.should have_tag("lists") do |lists|
          PublicCarrier.all.each do |public_carrier|
            lists.should have_tag("list", :name => public_carrier.name) do |list|
              public_carrier.trunks.each do |trunk|
                list.should have_tag("node", :name => trunk.name, :weight => trunk.weight.to_s)
              end
            end
          end
        end
      end


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
    fixtures :clients

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
      Freeswitch.find_by_ip('127.0.0.1').sip_profiles.each{|sip_profile|
        sip_profile.public_carriers.each{|cr|
          response.body.should have_tag("gateway", :name => cr.name) do |gateway|
            gateway.should have_tag('param',:name => "password", :value => cr.sip_pass.to_s)
            gateway.should have_tag('param',:name => "username", :value => cr.sip_user.to_s)
            gateway.should have_tag('param',:name => "realm", :value => cr.ip.to_s)
            gateway.should have_tag('param',:name => "register", :value => cr.authenticate.to_s)
          end
        }
      }
    end
    
    it "should return proxy media" do
      post "/directory.xml", {'FreeSWITCH-IPv4' => '127.0.0.1', 'section'=>'directory', 'tag_name'=>'domain', 'key_name' => 'name'}
      response.body.should have_tag('user') do |user|
        user.should have_tag('params') do |param|
          param.should have_tag('param', :name => 'inbound-proxy-media', :value => 'false')
        end
      end
      Client.all.each {|client| 
        client.sip_clients.each {|sip_client|
          sip_client.proxy_media = 'media'; 
          sip_client.save(:validate => false)
        }
      }


      post "/directory.xml", {'FreeSWITCH-IPv4' => '127.0.0.1', 'section'=>'directory', 'tag_name'=>'domain', 'key_name' => 'name'}
      response.body.should have_tag('user') do |user|
        user.should have_tag('params') do |param|
          param.should have_tag('param', :name => 'inbound-proxy-media', :value => 'true')
        end
      end
    end

    it "should return bypass media" do
      post "/directory.xml", {'FreeSWITCH-IPv4' => '127.0.0.1', 'section'=>'directory', 'tag_name'=>'domain', 'key_name' => 'name'}
      response.body.should have_tag('user') do |user|
        user.should have_tag('params') do |param|
          param.should have_tag('param', :name => 'inbound-bypass-media', :value => 'false')
        end
      end
      Client.all.each {|client| 
        client.sip_clients.each {|sip_client|
          sip_client.proxy_media = 'bypass'; 
          sip_client.save(:validate => false)
        }
      }

      post "/directory.xml", {'FreeSWITCH-IPv4' => '127.0.0.1', 'section'=>'directory', 'tag_name'=>'domain', 'key_name' => 'name'}
      response.body.should have_tag('user') do |user|
        user.should have_tag('params') do |param|
          param.should have_tag('param', :name => 'inbound-bypass-media', :value => 'true')
        end
      end
    end
    
  end

  describe "POST /xml_cdr" do
    it "should be ok" do
      post xml_cdr_path
      response.status.should be(200)
    end
  end

end
