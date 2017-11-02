class MakeAuditCommentMediumtext < ActiveRecord::Migration[5.1]
  def change
    change_column :audits, :comment, :text, limit: 16.megabytes - 1
  end
end
