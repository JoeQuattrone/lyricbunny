require 'pry'
class SongsController < ApplicationController

  # GET /songs
  def index
    @songs = Song.all

    render json: @songs
  end

  def update_likes
    @song = Song.find_by(track_id: params[:song][:track][:track_id])
    if @song
      @song.update(likes: @song.likes + 1)
    else
      @song = Song.create(track_id: params[:song][:track][:track_id], track_name: params[:song][:track][:track_name], likes: 1, genre: params[:song][:track]["primary_genres"]["music_genre_list"].first["music_genre"]["music_genre_name"], artist_name: params[:song][:track][:artist_name] )
    end
  end

  def trending_songs
    @songs = Song.trending_songs
    render json: @songs
  end

  # GET /songs/1
  def show
    render json: @song
  end

  # POST /songs
  def create
    @song = Song.new(song_params)

    if @song.save
      render json: @song, status: :created, location: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/1
  def update
    if @song.update(song_params)
      render json: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def song_params
      params.fetch(:song, {})
    end
end
