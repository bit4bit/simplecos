require 'spec_helper'

describe "trunks/edit" do
  before(:each) do
    @trunk = assign(:trunk, stub_model(Trunk,
      :name => "MyString",
      :ip => "MyString",
      :port => "MyString",
      :sip_user => "MyString",
      :sip_pass => "MyString",
      :authenticate => false,
      :bridge => "MyString",
      :public_carrier => nil
    ))
  end

  it "renders the edit trunk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => trunks_path(@trunk), :method => "post" do
      assert_select "input#trunk_name", :name => "trunk[name]"
      assert_select "input#trunk_ip", :name => "trunk[ip]"
      assert_select "input#trunk_port", :name => "trunk[port]"
      assert_select "input#trunk_sip_user", :name => "trunk[sip_user]"
      assert_select "input#trunk_sip_pass", :name => "trunk[sip_pass]"
      assert_select "input#trunk_authenticate", :name => "trunk[authenticate]"
      assert_select "input#trunk_bridge", :name => "trunk[bridge]"
      assert_select "input#trunk_public_carrier", :name => "trunk[public_carrier]"
    end
  end
end
