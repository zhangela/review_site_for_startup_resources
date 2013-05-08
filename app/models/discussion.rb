class Discussion < ActiveRecord::Base
  belongs_to :review
  attr_accessible :review_id, :to_user_id, :from_user_id, :review_id, :public_name
  has_many :comments

end
