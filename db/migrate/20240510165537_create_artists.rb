class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :photo
      t.date :birth_year
      t.string :country
      t.integer :user_artist_id
      t.integer :inspiration_id
      t.boolean :visibility
      t.integer :artworks_count

      t.timestamps
    end
  end
end
