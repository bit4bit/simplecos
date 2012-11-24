require 'spec_helper'

describe "clients/new" do
  before(:each) do
    assign(:client, stub_model(Client,
      :name => "MyString",
      :hashed_password => "MyString",
      :sip_user => "MyString",
      :sip_pass => "MyString",
      :public_carrier_id => 1,
      :balance => 1.5
    ).as_new_record)
  end

  it "renders new client form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clients_path, :method => "post" do
      assert_select "input#client_name", :name => "client[name]"
      assert_select "input#client_password", :name => "client[password]"
      assert_select "input#client_password_confirmation", :name => "client[password_confirmation]"
      assert_select "input#client_sip_user", :name => "client[sip_user]"
      assert_select "input#client_sip_pass", :name => "client[sip_pass]"
      assert_select "input#client_public_carrier_id", :name => "client[public_carrier_id]"
      assert_select "input#client_balance", :name => "client[balance]"
    end
  end
end
