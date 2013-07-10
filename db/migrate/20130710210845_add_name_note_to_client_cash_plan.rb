class AddNameNoteToClientCashPlan < ActiveRecord::Migration
  def change
    add_column :client_cash_plans, :name, :string, :default => ""
    add_column :client_cash_plans, :note, :text, :default => ""
  end
end
