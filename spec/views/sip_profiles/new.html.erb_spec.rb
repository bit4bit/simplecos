require 'spec_helper'

describe "sip_profiles/new" do
  before(:each) do
    assign(:sip_profile, stub_model(SipProfile,
      :name => "MyString",
      :inbound_codec => "MyString",
      :outbound_codec => "MyString",
      :rtp_ip => "MyString",
      :sip_ip => "MyString",
      :sip_port => 1,
      :freeswitch => nil
    ).as_new_record)
  end

  it "renders new sip_profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sip_profiles_path, :method => "post" do
      assert_select "input#sip_profile_name", :name => "sip_profile[name]"
      assert_select "input#sip_profile_inbound_codec", :name => "sip_profile[inbound_codec]"
      assert_select "input#sip_profile_outbound_codec", :name => "sip_profile[outbound_codec]"
      assert_select "input#sip_profile_rtp_ip", :name => "sip_profile[rtp_ip]"
      assert_select "input#sip_profile_sip_ip", :name => "sip_profile[sip_ip]"
      assert_select "input#sip_profile_sip_port", :name => "sip_profile[sip_port]"
      assert_select "input#sip_profile_freeswitch", :name => "sip_profile[freeswitch]"
    end
  end
end
