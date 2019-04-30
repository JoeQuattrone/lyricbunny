class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.belongs_to :artist
      t.string :title
      t.string :image_url
      t.text :lyrics
      t.integer :likes
      t.timestamps
    end
  end
end
