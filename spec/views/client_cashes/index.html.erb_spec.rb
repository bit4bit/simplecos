require 'spec_helper'

describe "client_cashes/index" do
  before(:each) do
    assign(:client_cashes, [
      stub_model(ClientCash,
        :client_id => 1,
        :amount => 1.5
      ),
      stub_model(ClientCash,
        :client_id => 1,
        :amount => 1.5
      )
    ])
  end

  it "renders a list of client_cashes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
