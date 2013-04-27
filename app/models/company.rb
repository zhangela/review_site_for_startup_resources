class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url
    has_many :reviews, :as => :reviewable
    has_many :partners

    belongs_to :category

    def default_values
        self.avg_rating ||= -1
    end

    #called whenever a new review is submitted
    def recalculate_average(review)
    	#if no reviews have been submitted
    	if(self.avg_rating == -1)
    		self.update_attribute(:avg_rating, review.rating)
    	else
			oldAvg = self.avg_rating 
    		numRatings = self.reviews.size
			oldTotal = oldAvg * (numRatings-1)

    		newAvg = (oldTotal + review.rating) / (numRatings)

    		self.update_attribute(:avg_rating, newAvg)
    	end
    end

    def self.search(search)
        if search
            where('name LIKE ?', "%#{search}%")
        else
            scoped
        end
    end

end
