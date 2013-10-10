class AddAllowAdminSipAccounts < ActiveRecord::Migration
  def change
    add_column :clients, :allow_admin_sip_accounts, :bool, :default => true
  end

end
