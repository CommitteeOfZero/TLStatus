class Project < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  has_many :scripts, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :language, presence: true, inclusion: { in: %w(nss) }
end
