class Review < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :rating, :reviewable_id, :reviewable_type, :title
end
