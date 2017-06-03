class Project < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  has_many :scripts, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :language, presence: true, inclusion: { in: %w(nss) }
  
  def self.where_user_is_not_member(user)
    self.where(ProjectMembership.where('project_id = projects.id AND user_id = ?', user.id).exists.not)
  end
end
