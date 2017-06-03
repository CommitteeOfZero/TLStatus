class MakeScriptContentBigtext < ActiveRecord::Migration[5.1]
  def change
    change_column :scripts, :text, :text, limit: 4.gigabytes - 1
  end
end
