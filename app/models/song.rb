class Song < ApplicationRecord
  validates :track_id, uniqueness: true

  def self.trending_songs
    self.all.sort_by {|song| song.likes}.reverse!.take(3)
  end

  def self.find_or_create_by_track_id(data)
    Song.find_or_create_by!(track_id: data["track"]["track_id"]) do |s|
      s.artist_name = data["track"]["artist_name"]
      s.track_name = data["track"]["track_name"]
      s.genre = data["track"]["primary_genres"]["music_genre_list"].first["music_genre"]["music_genre_name"] rescue nil
      s.likes = 0
    end
  end

end
