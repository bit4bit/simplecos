class CreateClientCashes < ActiveRecord::Migration
  def change
    create_table :client_cashes do |t|
      t.integer :client_id
      t.float :amount

      t.timestamps
    end
  end
end
