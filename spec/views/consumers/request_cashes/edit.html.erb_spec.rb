require 'spec_helper'

describe "consumers_request_cashes/edit" do
  before(:each) do
    @request_cash = assign(:request_cash, stub_model(Consumers::RequestCash,
      :client_id => 1,
      :amount => 1.5,
      :note => "MyText"
    ))
  end

  it "renders the edit request_cash form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => consumers_request_cashes_path(@request_cash), :method => "post" do
      assert_select "input#request_cash_client_id", :name => "request_cash[client_id]"
      assert_select "input#request_cash_amount", :name => "request_cash[amount]"
      assert_select "textarea#request_cash_note", :name => "request_cash[note]"
    end
  end
end
