require 'spec_helper'

describe "freeswitches/index" do
  before(:each) do
    assign(:freeswitches, [
      stub_model(Freeswitch,
        :name => "Name",
        :ip => "Ip"
      ),
      stub_model(Freeswitch,
        :name => "Name",
        :ip => "Ip"
      )
    ])
  end

  it "renders a list of freeswitches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
  end
end
