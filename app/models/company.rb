class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :partners_average, :description, :name, :url, :category, :location, :add_from_crunchbase, :num_partner_reviews
    has_many :reviews, :as => :reviewable
    has_many :partners

    validates_presence_of :description, :name, :url, :category, :location

    # default average rating to -1 so we can check for it and display "not yet rated."
    def default_values
        self.avg_rating ||= -1
        self.partners_average ||= -1
        self.num_partner_reviews ||= 0
    end

    #calculates the average rating of all partners, called when a new partner review is submitted or a review is updated
    def recalculate_partners_average(review)
        #if no partners have been reviewed
        if(self.partners_average == -1)
            self.update_attribute(:partners_average, review.rating)
        else
            #recalculate average rating across all partners
            oldPartnersAvg = self.partners_average
            oldNumPartnerReviews = self.num_partner_reviews
            if caller.grep /create/
                oldPartnerTotal = oldAvg * (oldNumPartnerReviews-1)
            elsif caller.grep /update/
                oldPartnerTotal = oldAvg * (oldNumPartnerReviews)
            end

            newPartnersAvg = (oldPartnerTotal + review.rating) / (oldNumPartnerReviews)

            #recalculate average rating of company
            companyTotal = self.avg_rating*self.reviews.size
            newCompanyAvg = (companyTotal + oldPartnerTotal + review.rating) / (oldNumPartnerReviews + self.reviews.size)

            self.update_attributes(:partners_average=>newPartnersAvg, :avg_rating=>newCompanyAvg, :num_partner_reviews=>(self.num_partner_reviews+1))
        end
    end

    #called whenever a new review is submitted or a review is updated on the company
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

            numPartnerReviews = self.num_partner_reviews
            partnerTotal = (self.partners_average * self.num_partner_reviews)

            newAvg = (oldTotal + partnerTotal + review.rating) / (self.num_partner_reviews + numRatings)

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
