class Song < ApplicationRecord
  validates :track_id, uniqueness: true

  def self.trending_songs
    self.all.sort {|song| song.likes}.take(3)
  end
end
