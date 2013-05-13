class AddProsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :pros, :text
  end
end
