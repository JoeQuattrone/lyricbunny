class ChangeCreateSongGenre < ActiveRecord::Migration[5.2]
  def change
    change_column :songs, :genre, :string, :null => true
  end
end
