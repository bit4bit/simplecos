require 'spec_helper'

describe "public_carriers/new" do
  before(:each) do
    assign(:public_carrier, stub_model(PublicCarrier,
      :name => "MyString",
      :sip_user => "MyString",
      :sip_pass => "MyString",
      :authenticate => false,
      :ip => "MyString",
      :port => 1
    ).as_new_record)
  end

  it "renders new public_carrier form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => public_carriers_path, :method => "post" do
      assert_select "input#public_carrier_name", :name => "public_carrier[name]"
      assert_select "input#public_carrier_sip_user", :name => "public_carrier[sip_user]"
      assert_select "input#public_carrier_sip_pass", :name => "public_carrier[sip_pass]"
      assert_select "input#public_carrier_authenticate", :name => "public_carrier[authenticate]"
      assert_select "input#public_carrier_ip", :name => "public_carrier[ip]"
      assert_select "input#public_carrier_port", :name => "public_carrier[port]"
    end
  end
end
