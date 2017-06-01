class Script < ApplicationRecord
  belongs_to :project
  
  validates :name, presence: true,
                   length: { maximum: 191 },
                   uniqueness: { scope: :project, case_sensitive: false }
  validates :text, presence: true
  validates :stage, presence: true,
                    inclusion: { in: %w(untouched translation tlc editing review finalised) }
end
