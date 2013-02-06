require 'spec_helper'

describe "client_cash_plans/edit" do
  before(:each) do
    @client_cash_plan = assign(:client_cash_plan, stub_model(ClientCashPlan,
      :client_id => 1,
      :expression => "MyString",
      :bill_rate => 1.5,
      :bill_minimum => 1,
      :bridge => "MyString",
      :public_carrier_id => 1
    ))
  end

  it "renders the edit client_cash_plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => client_cash_plans_path(@client_cash_plan), :method => "post" do
      assert_select "input#client_cash_plan_client_id", :name => "client_cash_plan[client_id]"
      assert_select "input#client_cash_plan_expression", :name => "client_cash_plan[expression]"
      assert_select "input#client_cash_plan_bill_rate", :name => "client_cash_plan[bill_rate]"
      assert_select "input#client_cash_plan_bill_minimum", :name => "client_cash_plan[bill_minimum]"
      assert_select "input#client_cash_plan_bridge", :name => "client_cash_plan[bridge]"
      assert_select "input#client_cash_plan_public_carrier_id", :name => "client_cash_plan[public_carrier_id]"
    end
  end
end
