class CreateTrunks < ActiveRecord::Migration
  def change
    create_table :trunks do |t|
      t.string :name
      t.string :ip
      t.string :port
      t.string :sip_user
      t.string :sip_pass
      t.boolean :authenticate, :default => false
      t.string :bridge
      t.references :public_carrier

      t.timestamps
    end
    add_index :trunks, :public_carrier_id
  end
end
