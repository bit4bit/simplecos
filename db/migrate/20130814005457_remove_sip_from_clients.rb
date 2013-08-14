class RemoveSipFromClients < ActiveRecord::Migration
  def up
    remove_column :clients, :sip_user
    remove_column :clients, :sip_pass
    remove_column :clients, :proxy_media
    remove_column :clients, :bypass_media
  end

  def down
    add_column :clients, :sip_user, :string
    add_column :clients, :sip_pass, :string
    add_column :clients, :proxy_media, :boolean, :default => false
    add_column :clients, :bypass_media, :boolean, :default => false
  end
end
