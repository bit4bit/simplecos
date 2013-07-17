require 'spec_helper'

describe "trunks/show" do
  before(:each) do
    @trunk = assign(:trunk, stub_model(Trunk,
      :name => "Name",
      :ip => "Ip",
      :port => "Port",
      :sip_user => "Sip User",
      :sip_pass => "Sip Pass",
      :authenticate => false,
      :bridge => "Bridge",
      :public_carrier => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Ip/)
    rendered.should match(/Port/)
    rendered.should match(/Sip User/)
    rendered.should match(/Sip Pass/)
    rendered.should match(/false/)
    rendered.should match(/Bridge/)
    rendered.should match(//)
  end
end
