class Version < ApplicationRecord
  has_many :line_counts

  def key_chars
    key_chars_hash = {}
    self.line_counts.order(count: :desc).includes(:character).take(5).each do |line_count|
      key_chars_hash[line_count.character.name] = line_count.count
    end
    key_chars_hash
  end

  def all_chars
    line_counts = LineCount.includes(:character).where(version_id: self.id).order(count: :desc) #this instead of @version.line_counts so it is sorted
    character_count = {}
    line_counts.each do |line_count|
      character_count[line_count.character.name] = line_count.count
    end
    character_count
  end

end
