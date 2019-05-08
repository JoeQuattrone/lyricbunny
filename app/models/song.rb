class Song < ApplicationRecord
  validates :track_id, uniqueness: true

  def self.trending_songs
    self.all.sort_by {|song| song.likes}.reverse!.take(3)
  end
end
