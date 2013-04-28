class AddPrivateDiscussionAttributes < ActiveRecord::Migration
  def change
  	add_column :discussions, :user_id, :integer
  	add_column :discussions, :to_user_id, :integer
  end
end
