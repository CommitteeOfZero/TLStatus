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
  
  def story_scripts
    scripts.where(story: true)
  end
  
  def completion_counts
    return @counts unless @counts.nil?
    @counts = {}
    @counts['finalised'] = story_scripts.where(stage: 'finalised').size
    @counts['review'] = @counts['finalised'] + story_scripts.where(stage: 'review').size
    @counts['editing'] = @counts['review'] + story_scripts.where(stage: 'editing').size
    @counts['tlc'] = @counts['editing'] + story_scripts.where(stage: 'tlc').size
    @counts['translation'] = @counts['tlc'] + story_scripts.where(stage: 'translation').size
    return @counts
  end
end
