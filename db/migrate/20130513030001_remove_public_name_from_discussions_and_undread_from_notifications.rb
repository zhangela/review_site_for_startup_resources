class RemovePublicNameFromDiscussionsAndUndreadFromNotifications < ActiveRecord::Migration
  def change
  	remove_column :notifications, :undread
  	remove_column :discussions, :public_name
  end
end
