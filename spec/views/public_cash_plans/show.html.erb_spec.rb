require 'spec_helper'

describe "public_cash_plans/show" do
  before(:each) do
    @public_cash_plan = assign(:public_cash_plan, stub_model(PublicCashPlan,
      :public_carrier_id => 1,
      :expression => "Expression",
      :bill_rate => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Expression/)
    rendered.should match(/1.5/)
  end
end
