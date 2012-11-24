class AddIndexs < ActiveRecord::Migration
  def up
    add_index :freeswitches, :ip
    add_index :public_carriers, :freeswitch_id
    add_index :public_cash_plans, :public_carrier_id
    add_index :client_cashes, :client_id
  end

  def down
  end
end
