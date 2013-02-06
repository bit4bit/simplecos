class CreateClientCashPlans < ActiveRecord::Migration
  def change
    create_table :client_cash_plans do |t|
      t.integer :client_id
      t.string :expression
      t.float :bill_rate
      t.integer :bill_minimum
      t.string :bridge
      t.integer :public_carrier_id

      t.timestamps
    end
  end
end
