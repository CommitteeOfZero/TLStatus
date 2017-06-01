class User < ApplicationRecord
  has_many :projects, through: :project_memberships
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :discord_uid, presence: true, length: { maximum: 20 }, uniqueness: true, numericality: true
end
