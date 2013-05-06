class AddReviewIdToActivities < ActiveRecord::Migration
  def change
  	add_column :activities, :review_id, :integer
  end
end
