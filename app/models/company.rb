class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url
    has_many :reviews, :as => :reviewable
    has_many :partners

    def default_values
        self.avg_rating ||= -1
    end

    #called whenever a new review is submitted
    def recalculate_average(review)
        puts "1111111111111111111111111"
    	#if no reviews have been submitted
    	if(self.avg_rating == -1)
            puts "222222222222222222222222222222"
    		self.update_attribute(:avg_rating, review.rating)
    	else
            puts "3333333333333333333333333333"
			oldAvg = self.avg_rating 
    		numRatings = self.reviews.size
			oldTotal = oldAvg * (numRatings-1)

    		newAvg = (oldTotal + review.rating) / (numRatings)

    		self.update_attribute(:avg_rating, newAvg)
    	end
    end

end
