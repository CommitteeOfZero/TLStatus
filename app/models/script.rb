class Script < ApplicationRecord
  belongs_to :project
  has_many :cached_notes, -> { order line: :asc }
  
  after_save :update_note_cache
  
  audited
  
  validates :name, presence: true,
                   length: { maximum: 191 },
                   uniqueness: { scope: :project, case_sensitive: false }
  validates :text, presence: true
  validates :stage, presence: true,
                    inclusion: { in: %w(untouched translation tlc editing review finalised) }
                    
private
  def update_note_cache
    cached_notes.destroy_all
    lines = text.split "\n"
    lines.each_with_index do |text, number|
      if text.start_with? "//note("
        matches = text.scan(/^\/\/note\((.*),(\s*)(.+)\):(.*)/)
        next if matches.count != 1 || matches[0].count != 4
        cached_notes.create(user: User.find_by(name: matches[0][0]),
                            added_at: Time.parse(matches[0][2]),
                            line: number,
                            text: matches[0][3].strip)
      end
    end
  end
end
