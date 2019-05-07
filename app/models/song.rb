class Song < ApplicationRecord
  validates :track_id, uniqueness: true

  def top_three
    Song.all.sort {|song| song.likes}.reverse!.take(3)
  end
end
