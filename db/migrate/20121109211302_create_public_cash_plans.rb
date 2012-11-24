class CreatePublicCashPlans < ActiveRecord::Migration
  def change
    create_table :public_cash_plans do |t|
      t.integer :public_carrier_id
      t.string :expression
      t.float :bill_rate

      t.timestamps
    end
  end
end
