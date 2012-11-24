require 'spec_helper'

describe "client_cashes/new" do
  before(:each) do
    assign(:client_cash, stub_model(ClientCash,
      :client_id => 1,
      :amount => 1.5
    ).as_new_record)
  end

  it "renders new client_cash form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => client_cashes_path, :method => "post" do
      assert_select "input#client_cash_client_id", :name => "client_cash[client_id]"
      assert_select "input#client_cash_amount", :name => "client_cash[amount]"
    end
  end
end
