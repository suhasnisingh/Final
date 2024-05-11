class CreateUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :updates do |t|
      t.string :photo
      t.text :body
      t.integer :project_id

      t.timestamps
    end
  end
end
