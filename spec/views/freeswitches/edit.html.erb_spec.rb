require 'spec_helper'

describe "freeswitches/edit" do
  before(:each) do
    @freeswitch = assign(:freeswitch, stub_model(Freeswitch,
      :name => "MyString",
      :ip => "MyString"
    ))
  end

  it "renders the edit freeswitch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => freeswitches_path(@freeswitch), :method => "post" do
      assert_select "input#freeswitch_name", :name => "freeswitch[name]"
      assert_select "input#freeswitch_ip", :name => "freeswitch[ip]"
    end
  end
end
