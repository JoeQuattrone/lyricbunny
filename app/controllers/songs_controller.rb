require 'pry'
require 'faraday'
require 'faraday_middleware'

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
      @song = Song.create(track_id: params[:song][:track][:track_id], track_name: params[:song][:track][:track_name], likes: 1, genre: "N/A", artist_name: params[:song][:track][:artist_name] )

      @song.update(genre: params[:song][:track]["primary_genres"]["music_genre_list"].first["music_genre"]["music_genre_name"]) if !params[:song][:track]["primary_genres"]["music_genre_list"].empty?
    end
  end
  # params[:song][:track]["primary_genres"]["music_genre_list"].first["music_genre"]["music_genre_name"]

  def update_likes_from_home
    @song = Song.find_by(track_id: params[:song][:track_id])
    @song.update(likes: @song.likes + 1) if @song
  end

  def trending_songs
    @songs = Song.trending_songs
    render json: @songs
  end

  def popular_songs
    url = 'http://api.musixmatch.com/ws/1.1/chart.tracks.get?chart_name=top&page=1&page_size=6&country=it&f_has_lyrics=1&apikey=523ebe747e1a258aaddd09f97f90cb70'

    conn = Faraday.new(url: url) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.response :json
    end
    response = conn.get
    response.body
    track_list = response.body["message"]["body"]["track_list"]

    @songs = []
    track_list.each {|song| @songs << Song.find_or_create_by_track_id(song)}
    render json: @songs
  end
  # search db for songs or create new ones. render json @songs

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
