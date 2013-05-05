class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :created_at, :review_id
  belongs_to :discussion
  belongs_to :user

  include PublicActivity::Common
  # tracked owner: ->(controller, model) { controller && controller.current_user }
end
