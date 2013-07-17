require 'spec_helper'

describe "trunks/index" do
  before(:each) do
    assign(:trunks, [
      stub_model(Trunk,
        :name => "Name",
        :ip => "Ip",
        :port => "Port",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :authenticate => false,
        :bridge => "Bridge",
        :public_carrier => nil
      ),
      stub_model(Trunk,
        :name => "Name",
        :ip => "Ip",
        :port => "Port",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :authenticate => false,
        :bridge => "Bridge",
        :public_carrier => nil
      )
    ])
  end

  it "renders a list of trunks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => "Port".to_s, :count => 2
    assert_select "tr>td", :text => "Sip User".to_s, :count => 2
    assert_select "tr>td", :text => "Sip Pass".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Bridge".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
