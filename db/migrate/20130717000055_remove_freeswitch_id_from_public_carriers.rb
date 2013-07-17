class RemoveFreeswitchIdFromPublicCarriers < ActiveRecord::Migration
  def up
    remove_column :public_carriers, :freeswitch_id
  end

  def down
    add_column :public_carriers, :freeswitch_id, :integer
  end
end
