#@todo no deberia ir aqui despues se refactoring :)
xml.instruct! :xml, :version => '1.0'

#Perfiles externos
if @data['purpose'] == 'gateways' and @data['profile'] == 'external'
  xml.document :type => 'freeswitch/xml' do
    xml.section :name => 'directory' do
      @freeswitch.sip_profiles.each do |sip_profile| 
        sip_profile.public_carriers.each do |carrier|
          xml.gateway :name => carrier.name do
            xml.param :name => 'username', :value => carrier.sip_user
            xml.param :name => 'password', :value => carrier.sip_pass
            xml.param :name => 'register', :value => carrier.authenticate
            xml.param :name => 'realm', :value => carrier.ip
          end
        end
      end #carriers
    end #xml.sectien
  end #xml.document
#elsif @data['purpose'] == 'gateways' and @data['profile'] == 'internal'

else
  xml.document :type => "freeswitch/xml" do
    xml.section :name => "result" do
      xml.result :status => "not found"
    end
  end
end
