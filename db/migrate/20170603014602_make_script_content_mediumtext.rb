class MakeScriptContentMediumtext < ActiveRecord::Migration[5.1]
  def change
    change_column :scripts, :text, :text, limit: 16.megabytes - 1
  end
end
