class FixNotificationsColumnName < ActiveRecord::Migration
  def up
  	rename_column :notifications, :type, :notify
  end

  def down
  end
end
