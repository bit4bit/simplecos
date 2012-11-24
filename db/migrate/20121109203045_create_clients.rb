class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :hashed_password
      t.string :sip_user
      t.string :sip_pass
      t.integer :public_carrier_id
      t.float :balance

      t.timestamps
    end
  end
end
