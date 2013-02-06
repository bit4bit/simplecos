class CreateAddProxyMediaToClients < ActiveRecord::Migration
  def change
    add_column :clients, :proxy_media, :boolean, :default => false
  end
end
