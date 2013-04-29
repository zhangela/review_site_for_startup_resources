class Comment < ActiveRecord::Base
  attr_accessible :body, :poster_email
  belongs_to :discussion
end
