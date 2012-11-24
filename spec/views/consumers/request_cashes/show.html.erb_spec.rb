require 'spec_helper'

describe "consumers_request_cashes/show" do
  before(:each) do
    @request_cash = assign(:request_cash, stub_model(Consumers::RequestCash,
      :client_id => 1,
      :amount => 1.5,
      :note => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/MyText/)
  end
end
