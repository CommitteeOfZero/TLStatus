class Project < ApplicationRecord
  has_many :members, through: :project_memberships, class_name: 'User'
  has_many :scripts
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :language, presence: true, inclusion: { in: %w(nss) }
end
