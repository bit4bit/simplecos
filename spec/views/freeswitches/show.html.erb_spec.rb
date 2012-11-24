require 'spec_helper'

describe "freeswitches/show" do
  before(:each) do
    @freeswitch = assign(:freeswitch, stub_model(Freeswitch,
      :name => "Name",
      :ip => "Ip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Ip/)
  end
end
