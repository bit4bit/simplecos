#@todo no deberia ir aqui despues se refactoring :)
if @data['section'] == 'directory' and @data['tag_name'] == 'domain' and @data['key_name'] == 'name'
  xml.document :type =>'freeswitch/xml' do
    xml.section :name => 'directory' , :description => 'internal simplecos' do
      xml.domain :name => @freeswitch.ip  do

          xml.groups do
            xml.group :name => "default" do
              xml.users do
              @freeswitch.sip_profiles.each do |sip_profile|
                sip_profile.public_carriers.each do |carrier|
                  @clients.each {|client|
                    client.sip_clients.each {|sip_client|
                      next unless client.public_carrier == carrier
                      xml.user :id => sip_client.sip_user do
                        xml.params {
                          xml.param :name => 'a1-hash', :value => Digest::MD5.hexdigest('%s:%s:%s' % [sip_client.sip_user, @freeswitch.ip, sip_client.sip_pass])
                          
                          xml.param :name => 'dial-string', :value => '[accountcode='+client.accountcode.to_s+']{sip_invite_domain=${dialed_domain},presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}'
                          xml.param :name => 'disable-transfer', :value => 'true'
                          xml.param :name => 'log-auth-failures', :value => 'true'
                          #segun: http://wiki.freeswitch.org/wiki/Proxy_Media
                          #@todo estos dos se excluyen

                          xml.param :name => 'inbound-bypass-media', :value => sip_client.proxy_media_bypass?
                          xml.param :name => 'inbound-proxy-media', :value => sip_client.proxy_media_proxy?

                        }
                        
                        xml.variables {
                          #xml.variable :name => 'user_context', :value => carrier.context
                          xml.variable :name => 'simplecos_account', :value => client.id
                          xml.variable :name => 'user_context', :value => 'public'
                          xml.variable :name => 'user_originated', :value => 'false'
                          xml.variable :name => 'toll_allow', :value => 'domestic,international,local'
                          xml.variable :name => 'sip-allow-multiple-registrations', :value => 'false'
                          xml.variable :name => 'default_gateway', :value => client.public_carrier.trunks.first.name
                          #para cobro
                          xml.variable :name => 'accountcode', :value => client.accountcode
                          xml.variable :name => 'effective_caller_id_number', :value => sip_client.caller_number
                          xml.variable :name => 'effective_caller_id_name', :value => sip_client.caller_name
                          xml.variable :name => 'outbound_caller_id_name', :value => '${effective_caller_id_name}'
                          xml.variable :name => 'outbound_caller_id_number', :value => '${effective_caller_id_number}'
                          #para cobro
                          xml.variable :name => 'nibble_account', :value => client.id
                          xml.variable :name => 'nibble_rate', :value => 0.0
                          xml.variable :name => 'max_calls', :value => sip_client.max_calls
			  xml.variable :name => 'sip-force-contact', :value => 'NDLB-connectile-dysfunction'
                        }
                      end
                    }
                  }
                  end
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
