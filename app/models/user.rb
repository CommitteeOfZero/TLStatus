class User < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  has_many :cached_notes
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :discord_uid, presence: true, length: { maximum: 20 }, uniqueness: true, numericality: true
  
  def self.where_not_member_of_project(project)
    self.where(ProjectMembership.where('project_id = ? AND user_id = users.id', project.id).exists.not)
  end
  
  def can_read?(project)
    self.admin? || !!self.project_memberships.find_by(project: project)
  end
  
  def can_write?(project)
    self.admin? || self.project_memberships.find_by(project: project).write_access?
  end
end
