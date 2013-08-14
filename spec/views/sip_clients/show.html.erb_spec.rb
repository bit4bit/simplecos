require 'spec_helper'

describe "sip_clients/show" do
  before(:each) do
    @sip_client = assign(:sip_client, stub_model(SipClient,
      :client => nil,
      :sip_user => "Sip User",
      :sip_pass => "Sip Pass",
      :proxy_media => "Proxy Media",
      :max_calls => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Sip User/)
    rendered.should match(/Sip Pass/)
    rendered.should match(/Proxy Media/)
    rendered.should match(/1/)
  end
end
