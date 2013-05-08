class Discussion < ActiveRecord::Base
  belongs_to :review
  attr_accessible :review_id, :to_user_id, :from_user_id, :private, :review_id, :anonymous
  has_many :comments

end
