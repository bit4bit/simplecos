xml.configuration :name => "distributor.conf", :description => "Distributor Configuration SIMPLECOS" do
  xml.lists do
    @public_carriers.each do |carrier|
      xml.list :name => carrier.name, 'total-weight' => carrier.total_weight do
        carrier.trunks.each do |trunk|
          xml.node :name => trunk.name, :weight => trunk.weight
        end
      end
    end
  end
end
