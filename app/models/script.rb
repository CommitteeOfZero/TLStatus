class Script < ApplicationRecord
  belongs_to :project
  has_many :cached_notes, -> { order line: :asc }
  
  scope :with_note_count, -> { left_joins(:cached_notes)
                               .group("scripts.id")
                               .select("scripts.*, count(cached_notes.id) as note_count") }
  
  before_save :strip_carriage_returns
  after_save :update_note_cache
  
  audited associated_with: :project
  
  validates :name, presence: true,
                   length: { maximum: 191 },
                   uniqueness: { scope: :project, case_sensitive: false }
  validates :text, presence: true
  validates :stage, presence: true,
                    inclusion: { in: %w(untouched translation tlc editing review finalised) }
                    
private
  # These mess with diffs
  def strip_carriage_returns
    text.delete! "\r"
  end
  
  def update_note_cache
    cached_notes.destroy_all
    lines = text.split "\n"
    lines.each_with_index do |text, number|
      if text.start_with? "//note("
        begin
          # TODO bring this into one regex
          matches_without_link = text.scan(/^\/\/note\((.*),\s*(.+)\):(.*)/)
          matches_with_link = text.scan(/^\/\/note\((.*),\s*(.+),\s*([a-z0-9]{6})\):(.*)/)
          if matches_with_link.count == 1 && matches_with_link[0].count == 4
            cached_notes.create(user: User.find_by(name: matches_with_link[0][0]),
                                added_at: Time.parse(matches_with_link[0][1]),
                                link: matches_with_link[0][2],
                                line: number,
                                text: matches_with_link[0][3].strip)
          elsif matches_without_link.count == 1 && matches_without_link[0].count == 3
            cached_notes.create(user: User.find_by(name: matches_without_link[0][0]),
                                added_at: Time.parse(matches_without_link[0][1]),
                                line: number,
                                text: matches_without_link[0][2].strip)
          end
        rescue
          # ignore this line
        end
      end
    end
  end
end
