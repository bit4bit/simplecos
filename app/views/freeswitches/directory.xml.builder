#@todo no deberia ir aqui despues se refactoring :)
if @data['section'] == 'directory' and @data['tag_name'] == 'domain' and @data['key_name'] == 'name'
  xml.document :type =>'freeswitch/xml' do
    xml.section :name => 'directory' , :description => 'internal simplecos' do
      xml.domain :name => @freeswitch.ip  do

          xml.groups do
            xml.group :name => "default" do
              xml.users do
              @freeswitch.public_carriers.each do |carrier|
                @clients.each {|client|

                  next unless client.public_carrier == carrier
                  xml.user :id => client.sip_user do
                    xml.params {
                      xml.param :name => 'a1-hash', :value => Digest::MD5.hexdigest('%s:%s:%s' % [client.sip_user, @freeswitch.ip, client.sip_pass])
                      
                      xml.param :name => 'dial-string', :value => '{sip_invite_domain=${dialed_domain},presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}'
                    }
                    
                    xml.variables {
                      #xml.variable :name => 'user_context', :value => carrier.context
                      xml.variable :name => 'simplecos_account', :value => client.id
                      xml.variable :name => 'user_context', :value => 'public'
                      xml.variable :name => 'user_originated', :value => 'true'
                      xml.variable :name => 'toll_allow', :value => 'domestic,international,local'
                      xml.variable :name => 'sip-allow-multiple-registrations', :value => 'false'
                      xml.variable :name => 'default_gateway', :value => client.public_carrier.name
                      xml.variable :name => 'accountcode', :value => client.sip_user
                      xml.variable :name => 'effective_caller_id_number', :value => client.sip_user
                      xml.variable :name => 'effective_caller_id_name', :value => client.name
                      xml.variable :name => 'outbound_caller_id_name', :value => '$${outbound_caller_name}'
                      xml.variable :name => 'outbound_caller_id_number', :value => '$${outbound_caller_id_number}'
                      xml.variable :name => 'nibble_account', :value => client.id
                      xml.variable :name => 'nibble_rate', :value => 100.0
                    }
                  end
                }
                end
              end
          end
        end
      end
    end
  end
else
  xml.instruct! :xml, :version => '1.0'
  xml.document :type => "freeswitch/xml" do
    xml.section :name => "result" do
      xml.result :status => "not found"
    end
  end
end
