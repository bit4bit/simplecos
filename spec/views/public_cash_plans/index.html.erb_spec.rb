require 'spec_helper'

describe "public_cash_plans/index" do
  before(:each) do
    assign(:public_cash_plans, [
      stub_model(PublicCashPlan,
        :public_carrier_id => 1,
        :expression => "Expression",
        :bill_rate => 1.5
      ),
      stub_model(PublicCashPlan,
        :public_carrier_id => 1,
        :expression => "Expression",
        :bill_rate => 1.5
      )
    ])
  end

  it "renders a list of public_cash_plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Expression".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
