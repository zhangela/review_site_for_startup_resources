class RemoveTypeFromDiscussions < ActiveRecord::Migration
  def change
  	remove_column :discussions, :type
  end
end
