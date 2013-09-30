class AddCallerNameToSipClients < ActiveRecord::Migration
  def change
    add_column :sip_clients, :caller_name, :string, :default => ""
  end
end
