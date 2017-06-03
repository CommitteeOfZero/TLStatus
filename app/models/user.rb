class User < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :discord_uid, presence: true, length: { maximum: 20 }, uniqueness: true, numericality: true
  
  def self.where_not_member_of_project(project)
    self.where(ProjectMembership.where('project_id = ? AND user_id = users.id', project.id).exists.not)
  end
end
