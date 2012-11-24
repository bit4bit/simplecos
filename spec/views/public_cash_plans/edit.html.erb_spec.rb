require 'spec_helper'

describe "public_cash_plans/edit" do
  before(:each) do
    @public_cash_plan = assign(:public_cash_plan, stub_model(PublicCashPlan,
      :public_carrier_id => 1,
      :expression => "MyString",
      :bill_rate => 1.5
    ))
  end

  it "renders the edit public_cash_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => public_cash_plans_path(@public_cash_plan), :method => "post" do
      assert_select "input#public_cash_plan_public_carrier_id", :name => "public_cash_plan[public_carrier_id]"
      assert_select "input#public_cash_plan_expression", :name => "public_cash_plan[expression]"
      assert_select "input#public_cash_plan_bill_rate", :name => "public_cash_plan[bill_rate]"
    end
  end
end
