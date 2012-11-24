require 'spec_helper'
#!!ni idea
describe 'freeswitch/directory' do
  before(:each) do
    carrier = stub_model(PublicCarrier,
                          :name => 'carrier1',
                          :ip => '127.0.0.1',
                          :port => 5060)
    @freeswitch = assign(:freeswitch, stub_model(Freeswitch,
                                                 :name => "Name",
                                                 :ip => "127.0.0.1",
                                                 :id => 1,
                                                 :public_carriers => [carrier]
                                                 ))

  end

end
