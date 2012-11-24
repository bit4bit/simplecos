class CreateConsumersRequestCashes < ActiveRecord::Migration
  def change
    create_table :consumers_request_cashes do |t|
      t.integer :client_id
      t.float :amount
      t.text :note

      t.timestamps
    end
  end
end
