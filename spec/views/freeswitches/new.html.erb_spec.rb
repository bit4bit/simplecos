require 'spec_helper'

describe "freeswitches/new" do
  before(:each) do
    assign(:freeswitch, stub_model(Freeswitch,
      :name => "MyString",
      :ip => "MyString"
    ).as_new_record)
  end

  it "renders new freeswitch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => freeswitches_path, :method => "post" do
      assert_select "input#freeswitch_name", :name => "freeswitch[name]"
      assert_select "input#freeswitch_ip", :name => "freeswitch[ip]"
    end
  end
end
