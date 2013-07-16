class CreateSipProfiles < ActiveRecord::Migration
  def change
    create_table :sip_profiles do |t|
      t.string :name
      t.string :inbound_codec
      t.string :outbound_codec
      t.string :rtp_ip
      t.string :sip_ip
      t.integer :sip_port
      t.references :freeswitch

      t.timestamps
    end
    add_index :sip_profiles, :freeswitch_id
  end
end
