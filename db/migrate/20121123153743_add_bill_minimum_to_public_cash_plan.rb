class AddBillMinimumToPublicCashPlan < ActiveRecord::Migration
  def change
    add_column :public_cash_plans, :bill_minimum, :integer, :default => 0
  end
end
