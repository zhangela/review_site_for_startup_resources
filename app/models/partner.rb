class Partner < ActiveRecord::Base
  attr_accessible :avg_rating, :name
  has_many :reviews, :as => :reviewable
end
