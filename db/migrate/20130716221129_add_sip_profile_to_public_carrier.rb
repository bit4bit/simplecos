class AddSipProfileToPublicCarrier < ActiveRecord::Migration
  def change
    add_column :public_carriers, :sip_profile_id, :integer, :references => "sip_profiles"
  end
end
