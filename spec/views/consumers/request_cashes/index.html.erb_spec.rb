require 'spec_helper'

describe "consumers_request_cashes/index" do
  before(:each) do
    assign(:consumers_request_cashes, [
      stub_model(Consumers::RequestCash,
        :client_id => 1,
        :amount => 1.5,
        :note => "MyText"
      ),
      stub_model(Consumers::RequestCash,
        :client_id => 1,
        :amount => 1.5,
        :note => "MyText"
      )
    ])
  end

  it "renders a list of consumers_request_cashes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
