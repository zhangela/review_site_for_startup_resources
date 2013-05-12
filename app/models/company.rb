class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url, :category, :location, :add_from_crunchbase
    has_many :reviews, :as => :reviewable
    has_many :partners

    validates_presence_of :description, :name, :url, :category, :location

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
           oldTotal = oldAvg * (numRatings-1)

           newAvg = (oldTotal + review.rating) / (numRatings)

           self.update_attribute(:avg_rating, newAvg)
       end
   end

   # custom wrote search function
   def self.search(search)
        if search
            where('name LIKE ? OR location LIKE ? OR description LIKE ? OR category LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
        else
            scoped
        end
    end

    # custom wrote filter by category function
    def self.filter_by_category(condition)
        if condition
            where('category LIKE ?', "%#{condition}%")
        else
            scoped
        end
    end

    # custom wrote filter by rating function
    def self.filter_by_rating(condition)
        if condition
            where('avg_rating >= ?', "#{condition}")
        else
            scoped
        end
    end
end
