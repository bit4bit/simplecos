class CreatePublicCarriers < ActiveRecord::Migration
  def change
    create_table :public_carriers do |t|
      t.string :name
      t.string :sip_user
      t.string :sip_pass
      t.boolean :authenticate
      t.string :ip
      t.integer :port

      t.timestamps
    end
  end
end
