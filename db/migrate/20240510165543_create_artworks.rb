class CreateArtworks < ActiveRecord::Migration[7.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :photo
      t.string :description
      t.date :year
      t.string :location
      t.integer :artist_id
      t.integer :style_id
      t.integer :inspiration_id
      t.integer :project_id
      t.boolean :visibility
      t.integer :likes_count
      t.integer :comments_count

      t.timestamps
    end
  end
end
