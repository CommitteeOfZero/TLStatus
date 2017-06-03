class MakeAuditChangesBigtext < ActiveRecord::Migration[5.1]
  def change
    change_column :audits, :audited_changes, :text, limit: 4.gigabytes - 1
  end
end
