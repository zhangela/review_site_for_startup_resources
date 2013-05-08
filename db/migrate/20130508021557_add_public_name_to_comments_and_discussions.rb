class AddPublicNameToCommentsAndDiscussions < ActiveRecord::Migration
  def change
  	add_column :comments, :public_name, :string
  	add_column :discussions, :public_name, :string
  end
end
