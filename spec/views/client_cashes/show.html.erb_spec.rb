require 'spec_helper'

describe "client_cashes/show" do
  before(:each) do
    @client_cash = assign(:client_cash, stub_model(ClientCash,
      :client_id => 1,
      :amount => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/1.5/)
  end
end
