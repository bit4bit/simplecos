class AddBypassMediaToClient < ActiveRecord::Migration
  def change
    add_column :clients, :bypass_media, :boolean, :default => false
  end
end
