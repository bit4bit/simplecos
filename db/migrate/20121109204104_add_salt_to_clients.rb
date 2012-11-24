class AddSaltToClients < ActiveRecord::Migration
  def change
    add_column :clients, :salt, :string, :default => ""
  end
end
