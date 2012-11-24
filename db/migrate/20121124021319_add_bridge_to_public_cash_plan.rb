class AddBridgeToPublicCashPlan < ActiveRecord::Migration
  def change
    add_column :public_cash_plans, :bridge, :string, :default => ''
  end
end
