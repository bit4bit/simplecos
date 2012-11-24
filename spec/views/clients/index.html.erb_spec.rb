require 'spec_helper'

describe "clients/index" do
  before(:each) do
    assign(:clients, [
      stub_model(Client,
        :name => "Name",
        :hashed_password => "Hashed Password",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :public_carrier_id => 1,
        :balance => 1.5
      ),
      stub_model(Client,
        :name => "Name",
        :hashed_password => "Hashed Password",
        :sip_user => "Sip User",
        :sip_pass => "Sip Pass",
        :public_carrier_id => 1,
        :balance => 1.5
      )
    ])
  end

  it "renders a list of clients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Hashed Password".to_s, :count => 2
    assert_select "tr>td", :text => "Sip User".to_s, :count => 2
    assert_select "tr>td", :text => "Sip Pass".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
