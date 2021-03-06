class ProjectMembership < ApplicationRecord
    belongs_to :project
    belongs_to :user
    
    validates :user, uniqueness: { scope: :project }
    validates :position, length: { maximum: 191 }
end
