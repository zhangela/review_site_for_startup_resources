class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification
      t.integer :user_id
      t.string :title
      t.string :body
      t.boolean :undread
      t.integer :review_id

      t.timestamps
    end
  end
end
