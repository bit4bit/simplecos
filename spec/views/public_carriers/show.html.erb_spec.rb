require 'spec_helper'

describe "public_carriers/show" do
  before(:each) do
    @public_carrier = assign(:public_carrier, stub_model(PublicCarrier,
      :name => "Name",
      :sip_user => "Sip User",
      :sip_pass => "Sip Pass",
      :authenticate => false,
      :ip => "Ip",
      :port => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Sip User/)
    rendered.should match(/Sip Pass/)
    rendered.should match(/false/)
    rendered.should match(/Ip/)
    rendered.should match(/1/)
  end
end
