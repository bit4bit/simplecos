require 'spec_helper'

describe "client_cash_plans/show" do
  before(:each) do
    @client_cash_plan = assign(:client_cash_plan, stub_model(ClientCashPlan,
      :client_id => 1,
      :expression => "Expression",
      :bill_rate => 1.5,
      :bill_minimum => 2,
      :bridge => "Bridge",
      :public_carrier_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Expression/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
    rendered.should match(/Bridge/)
    rendered.should match(/3/)
  end
end
