class Discussion < ActiveRecord::Base
  belongs_to :review
  attr_accessible :review_id
  has_many :comments
end
