class CreateDiscussionThreads < ActiveRecord::Migration
  def change
    create_table :discussion_threads do |t|

      t.timestamps
    end
  end
end
