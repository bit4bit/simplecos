class CreateSipClients < ActiveRecord::Migration
  def change
    create_table :sip_clients do |t|
      t.references :client_id
      t.string :sip_pass
      t.string :sip_user
      t.integer :max_calls
      t.string :proxy_media

      t.timestamps
    end
    add_index :sip_clients, :client_id_id
  end
end
