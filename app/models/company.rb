class Company < ActiveRecord::Base
  attr_accessible :avg_rating, :description, :name, :url
end
