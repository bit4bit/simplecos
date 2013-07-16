require 'spec_helper'

describe "sip_profiles/show" do
  before(:each) do
    @sip_profile = assign(:sip_profile, stub_model(SipProfile,
      :name => "Name",
      :inbound_codec => "Inbound Codec",
      :outbound_codec => "Outbound Codec",
      :rtp_ip => "Rtp Ip",
      :sip_ip => "Sip Ip",
      :sip_port => 1,
      :freeswitch => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Inbound Codec/)
    rendered.should match(/Outbound Codec/)
    rendered.should match(/Rtp Ip/)
    rendered.should match(/Sip Ip/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
