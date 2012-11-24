require 'spec_helper'

describe "public_carriers/index" do
  before(:each) do
    assign(:public_carriers, [
      stub_model(PublicCarrier,
        :name => "Name",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :authenticate => false,
        :ip => "Ip",
        :port => 1
      ),
      stub_model(PublicCarrier,
        :name => "Name",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :authenticate => false,
        :ip => "Ip",
        :port => 1
      )
    ])
  end

  it "renders a list of public_carriers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Sip User".to_s, :count => 2
    assert_select "tr>td", :text => "Sip Pass".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
