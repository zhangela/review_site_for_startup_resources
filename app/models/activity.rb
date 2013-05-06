class Activity < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_readable :on => :created_at
end
