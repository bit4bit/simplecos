class AddWeightToTrunks < ActiveRecord::Migration
  def change
    add_column :trunks, :weight, :integer, :default => 1
  end
end
