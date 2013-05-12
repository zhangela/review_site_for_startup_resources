class AddProsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :pros, :string
  end
end
