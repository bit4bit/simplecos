class AddFreeswitchToPublicCarriers < ActiveRecord::Migration
  def change
    add_column :public_carriers, :freeswitch_id, :integer
  end
end
