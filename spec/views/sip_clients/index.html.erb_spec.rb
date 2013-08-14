require 'spec_helper'

describe "sip_clients/index" do
  before(:each) do
    assign(:sip_clients, [
      stub_model(SipClient,
        :client => nil,
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :proxy_media => "Proxy Media",
        :max_calls => 1
      ),
      stub_model(SipClient,
        :client => nil,
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :proxy_media => "Proxy Media",
        :max_calls => 1
      )
    ])
  end

  it "renders a list of sip_clients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Sip User".to_s, :count => 2
    assert_select "tr>td", :text => "Sip Pass".to_s, :count => 2
    assert_select "tr>td", :text => "Proxy Media".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
