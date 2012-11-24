class AddDefaultBalanceToClient < ActiveRecord::Migration
  def change
    change_column :clients, :balance, :float, :default => 0.0
  end
end
