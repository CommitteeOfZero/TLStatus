class Project < ApplicationRecord
  has_many :project_memberships, dependent: :destroy
  has_many :scripts, dependent: :destroy
  has_many :cached_notes, through: :scripts
  
  has_associated_audits
  
  validates :name, presence: true, length: { maximum: 191 }, uniqueness: true
  validates :language, presence: true, inclusion: { in: %w(nss) }
  
  def self.where_user_is_not_member(user)
    self.where(ProjectMembership.where('project_id = projects.id AND user_id = ?', user.id).exists.not)
  end
  
  def completion_counts
    return @counts unless @counts.nil?
    @counts = {}
    @counts['finalised'] = scripts.where(stage: 'finalised').size
    @counts['review'] = @counts['finalised'] + scripts.where(stage: 'review').size
    @counts['editing'] = @counts['review'] + scripts.where(stage: 'editing').size
    @counts['tlc'] = @counts['editing'] + scripts.where(stage: 'tlc').size
    @counts['translation'] = @counts['tlc'] + scripts.where(stage: 'translation').size
    return @counts
  end
end
