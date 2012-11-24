require 'spec_helper'

describe "clients/show" do
  before(:each) do
    @client = assign(:client, stub_model(Client,
      :name => "Name",
      :hashed_password => "Hashed Password",
      :sip_user => "Sip User",
      :sip_pass => "Sip Pass",
      :public_carrier_id => 1,
      :balance => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Hashed Password/)
    rendered.should match(/Sip User/)
    rendered.should match(/Sip Pass/)
    rendered.should match(/1/)
    rendered.should match(/1.5/)
  end
end
