require 'spec_helper'

describe "sip_clients/edit" do
  before(:each) do
    @sip_client = assign(:sip_client, stub_model(SipClient,
      :client => nil,
      :sip_user => "MyString",
      :sip_pass => "MyString",
      :proxy_media => "MyString",
      :max_calls => 1
    ))
  end

  it "renders the edit sip_client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sip_clients_path(@sip_client), :method => "post" do
      assert_select "input#sip_client_client", :name => "sip_client[client]"
      assert_select "input#sip_client_sip_user", :name => "sip_client[sip_user]"
      assert_select "input#sip_client_sip_pass", :name => "sip_client[sip_pass]"
      assert_select "input#sip_client_proxy_media", :name => "sip_client[proxy_media]"
      assert_select "input#sip_client_max_calls", :name => "sip_client[max_calls]"
    end
  end
end
