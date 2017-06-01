class CreateScripts < ActiveRecord::Migration[5.1]
  def change
    create_table :scripts do |t|
      t.string :name, limit: 191
      t.text :text, null: false
      t.string :stage, null: false, default: "untouched"
      t.belongs_to :project, index: true

      t.timestamps
    end
    add_index :scripts, [:name, :project_id], unique: true
  end
end
