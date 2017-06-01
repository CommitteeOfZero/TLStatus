class User < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :discord_uid, presence: true, length: { maximum: 20 }, uniqueness: true, numericality: true
end
