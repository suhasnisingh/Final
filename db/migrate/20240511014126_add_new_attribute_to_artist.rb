class AddNewAttributeToArtist < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :artist_api_id, :string
  end
end
