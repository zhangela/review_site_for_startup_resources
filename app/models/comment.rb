class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :created_at
  belongs_to :discussion
  belongs_to :user
end
