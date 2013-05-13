class AddConsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :cons, :text
  end
end
