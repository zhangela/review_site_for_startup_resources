class AddAttributesToCommentAndRemoveBodyFromDiscussion < ActiveRecord::Migration
  def change
  	add_column :comments, :discussion_id, :integer
  	add_column :comments, :body, :text

  	remove_column :discussions, :body
  end
end
