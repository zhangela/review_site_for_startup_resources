class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id
  belongs_to :discussion
  belongs_to :user
end
