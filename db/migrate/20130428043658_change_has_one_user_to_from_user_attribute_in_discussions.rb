class ChangeHasOneUserToFromUserAttributeInDiscussions < ActiveRecord::Migration
  def change
  	remove_column :discussions, :user_id
  	add_column :discussions, :from_user_id, :integer
  end
end
