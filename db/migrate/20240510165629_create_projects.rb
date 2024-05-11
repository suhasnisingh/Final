class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :completed_photo
      t.text :desription
      t.string :status
      t.date :start_date
      t.date :finish_date
      t.text :other_notes
      t.integer :user_id
      t.integer :inspiration_id
      t.integer :artworks_count
      t.integer :updates_count

      t.timestamps
    end
  end
end
