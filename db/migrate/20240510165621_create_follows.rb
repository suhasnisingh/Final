class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.string :status

      t.timestamps
    end
  end
end
