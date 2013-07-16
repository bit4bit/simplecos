require 'spec_helper'

describe "sip_profiles/index" do
  before(:each) do
    assign(:sip_profiles, [
      stub_model(SipProfile,
        :name => "Name",
        :inbound_codec => "Inbound Codec",
        :outbound_codec => "Outbound Codec",
        :rtp_ip => "Rtp Ip",
        :sip_ip => "Sip Ip",
        :sip_port => 1,
        :freeswitch => nil
      ),
      stub_model(SipProfile,
        :name => "Name",
        :inbound_codec => "Inbound Codec",
        :outbound_codec => "Outbound Codec",
        :rtp_ip => "Rtp Ip",
        :sip_ip => "Sip Ip",
        :sip_port => 1,
        :freeswitch => nil
      )
    ])
  end

  it "renders a list of sip_profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Inbound Codec".to_s, :count => 2
    assert_select "tr>td", :text => "Outbound Codec".to_s, :count => 2
    assert_select "tr>td", :text => "Rtp Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Sip Ip".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
