class AddPublicNameToReview < ActiveRecord::Migration
  def change
  	add_column :reviews, :public_name, :string
  end
end
