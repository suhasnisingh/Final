class CreateInspirations < ActiveRecord::Migration[7.0]
  def change
    create_table :inspirations do |t|
      t.string :name
      t.string :description
      t.string :other_notes
      t.integer :user_id
      t.boolean :visibility
      t.integer :projects_count
      t.integer :artists_count
      t.integer :artworks_count

      t.timestamps
    end
  end
end
