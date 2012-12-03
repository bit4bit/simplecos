class AddMaxCallsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :max_calls, :integer, :default => 1
  end
end
