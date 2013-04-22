class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.text :body
      t.references :user
      t.integer :reviewable_id
      t.string :reviewable_type

      t.timestamps
    end
    add_index :reviews, :user_id
  end
end
