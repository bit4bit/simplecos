class AddAccountCodeToClient < ActiveRecord::Migration
  def change
    add_column :clients, :accountcode, :integer
  end
end
