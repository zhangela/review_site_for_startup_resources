class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :partners_average, :description, :name, :url, :category, :location, :add_from_crunchbase
    has_many :reviews, :as => :reviewable
    has_many :partners

    validates_presence_of :description, :name, :url, :category, :location

    # default average rating to -1 so we can check for it and display "not yet rated."
    def default_values
        self.avg_rating ||= -1
        self.partners_average ||= -1
    end

    #calculates the average rating of all partners, called when a new partner review is submitted
    def recalculate_partners_average(review)
        #if no partners have been reviewed
        if(self.partners == -1)
            self.update_attribute(:partners_average, review.rating)
        else
            #recalculate average rating across all partners
            oldAvg = self.partners_average
            numPartners = self.partners.size
            oldTotal = oldAvg * (numPartners-1)

            newAvg = (oldTotal + review.rating) / (numPartners)

            #recalculate average rating of company
            newCompanyAvg = (self.avg_rating + newAvg) / 2

            self.update_attributes(:partners_average=>newAvg, :avg_rating=>newCompanyAvg)
        end
    end

    #called whenever a new review is submitted on the company
    def recalculate_average(review)
    	#if no reviews have been submitted
    	if(self.avg_rating == -1)
            self.update_attribute(:avg_rating, review.rating)
        else
           oldAvg = self.avg_rating
           numRatings = self.reviews.size
           oldTotal = oldAvg * (numRatings-1)

    		newCompanyAvg = (oldTotal + review.rating) / (numRatings)
            partnerAvg = self.partners_average

            newAvg = (newCompanyAvg + partnerAvg) / 2

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
