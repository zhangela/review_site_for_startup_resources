class Partner < ActiveRecord::Base
    belongs_to :company
    has_many :reviews, :as => :reviewable

    attr_accessible :avg_rating, :name, :company_id, :email

    validates :name, :presence => true, :length => { :maximum => 100 }
    validates :company_id, :presence => true
    validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }


    before_save :default_values


    # default average rating to -1 so we can check for it and display "not yet rated."
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

         if caller.grep /create/
            oldTotal = oldAvg * (numRatings-1)
         elsif caller.grep /update/
            oldTotal = oldAvg * (numRatings)
         end

         newAvg = (oldTotal + review.rating) / (numRatings)

         self.update_attribute(:avg_rating, newAvg)
     end
 end

end