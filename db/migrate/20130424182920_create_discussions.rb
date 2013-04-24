class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.text :body
      t.references :review

      t.timestamps
    end
    add_index :discussions, :review_id
  end
end
