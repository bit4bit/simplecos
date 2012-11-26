xml.instruct! :xml, :version => '1.0'
xml.document :type => 'freeswitch/xml' do
  xml.section :name => 'dialplan', :description => 'Dialplan SimpleCOS' do
    xml.context :name => 'public' do
      xml.extension :name => 'test' do
        xml.condition :field => 'destination_number', :expression => '8888' do
          xml.action :application => 'set', :data => "simplecos_cash_plan=%d" % PublicCashPlan.first.id
          xml.action :application => 'set', :data => 'nibble_account=${user_data(${caller_id_number}@${domain_name} var nibble_account)}'
          xml.action :application => 'answer'
          xml.action :application => 'phrase', :data => 'msgcount,10'
          xml.action :application => 'hangup'
        end
      end
      
      @freeswitch.public_carriers.each{|carrier|
        carrier.public_cash_plans.each{|cash_plan|
          xml.extension :name => 'simplecos_%d' % cash_plan.id do
            xml.condition :field => 'destination_number', :expression => cash_plan.expression do
              xml.action :application => 'set', :data => "simplecos_cash_plan=#{cash_plan.id}"
              xml.action :application => 'set', :data => "nibble_rate=#{cash_plan.bill_rate}"
              xml.action :application => 'set', :data => 'nibble_account=${user_data(${caller_id_number}@${domain_name} var nibble_account)}'
              if cash_plan.bill_minimum > 0
                xml.action :application => 'set', :data => "nibble_increment=#{cash_plan.bill_minimum}"
              end

              if not cash_plan.bridge.empty?
                xml.action :application => 'bridge', :data => cash_plan.bridge
              else
                xml.action :application => 'bridge', :data => "sofia/gateway/#{carrier.name}/$1"
              end
            end
        end
        }
      }
    end
  end
end
