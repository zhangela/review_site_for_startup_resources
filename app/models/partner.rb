class Partner < ActiveRecord::Base
    belongs_to :company
    has_many :reviews, :as => :reviewable

    attr_accessible :avg_rating, :name, :company_id

    before_save :default_values

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

    		newAvg = (oldTotal + review.rating) / (numRatings + 1)

    		self.update_attribute(:avg_rating, newAvg)
    	end
    end

end