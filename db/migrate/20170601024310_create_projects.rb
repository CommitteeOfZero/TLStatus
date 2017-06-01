class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, limit: 191
      t.string :language, null: false

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
