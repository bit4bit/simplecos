class AddNameNoteToPublicCashPlan < ActiveRecord::Migration
  def change
    add_column :public_cash_plans, :name, :string, :default => ""
    add_column :public_cash_plans, :note, :text, :default => ""
  end
end
