class AddLinkToCachedNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :cached_notes, :link, :string, length: 6
  end
end
