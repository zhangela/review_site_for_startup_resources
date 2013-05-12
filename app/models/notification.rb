class Notification < ActiveRecord::Base
  attr_accessible :body, :review_id, :title, :undread, :user_id, :notify, :user_name
  acts_as_readable :on => :created_at

end
