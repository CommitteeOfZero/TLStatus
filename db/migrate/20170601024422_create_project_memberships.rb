class CreateProjectMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :project_memberships do |t|
      t.boolean :write_access, default: false
      t.string :position, limit: 191
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
    add_index :project_memberships, [:project_id, :user_id], unique: true
  end
end
