class CreateCachedNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :cached_notes do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :script, foreign_key: true
      t.text :text
      t.integer :line
      t.datetime :added_at
    end
  end
end
