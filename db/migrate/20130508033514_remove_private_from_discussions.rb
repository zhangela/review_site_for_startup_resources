class RemovePrivateFromDiscussions < ActiveRecord::Migration
  def change
  	remove_column :discussions, :private
  end
end
