class DropCategory < ActiveRecord::Migration
  def up
  	drop_table :categories
  end

  def down
  end
end
