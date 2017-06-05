class CachedNote < ApplicationRecord
  belongs_to :user
  belongs_to :script
  
  validates :link, format: { with: /\A[a-z0-9]{6}\z/ }, allow_blank: true
end
