class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :artist_name
      t.integer :track_id
      t.string :track_name
      t.string :genre
      t.integer :likes
      t.timestamps
    end
  end
end
