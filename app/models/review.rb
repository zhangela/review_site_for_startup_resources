class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  has_many :discussions
  attr_accessible :body, :rating, :reviewable_id, :reviewable_type, :title, :user_id, :review_id, :public_name, :pros, :cons
  validates_presence_of :title, :rating, :pros, :cons

end
