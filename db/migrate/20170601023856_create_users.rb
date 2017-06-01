class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 191
      t.string :discord_uid, limit: 20
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :users, :name, unique: true
    add_index :users, :discord_uid, unique: true
  end
end
