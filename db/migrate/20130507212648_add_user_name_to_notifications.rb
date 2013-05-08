class AddUserNameToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :user_name, :string
  end
end
