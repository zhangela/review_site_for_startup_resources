class Company < ActiveRecord::Base
  attr_accessible :avg_rating, :description, :name, :url
  has_many :reviews, :as => :reviewable
end
