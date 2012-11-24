class CreateFreeswitches < ActiveRecord::Migration
  def change
    create_table :freeswitches do |t|
      t.string :name
      t.string :ip

      t.timestamps
    end
  end
end
