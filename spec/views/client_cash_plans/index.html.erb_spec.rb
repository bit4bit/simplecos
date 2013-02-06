require 'spec_helper'

describe "client_cash_plans/index" do
  before(:each) do
    assign(:client_cash_plans, [
      stub_model(ClientCashPlan,
        :client_id => 1,
        :expression => "Expression",
        :bill_rate => 1.5,
        :bill_minimum => 2,
        :bridge => "Bridge",
        :public_carrier_id => 3
      ),
      stub_model(ClientCashPlan,
        :client_id => 1,
        :expression => "Expression",
        :bill_rate => 1.5,
        :bill_minimum => 2,
        :bridge => "Bridge",
        :public_carrier_id => 3
      )
    ])
  end

  it "renders a list of client_cash_plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Expression".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Bridge".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
