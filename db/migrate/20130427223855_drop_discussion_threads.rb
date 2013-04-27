class DropDiscussionThreads < ActiveRecord::Migration
  def change
  	drop_table :discussion_threads
  end
end
