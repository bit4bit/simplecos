class AddCallerNumberToSipClients < ActiveRecord::Migration
  def change
    add_column :sip_clients, :caller_number, :string, :default => "000000"
  end
end
