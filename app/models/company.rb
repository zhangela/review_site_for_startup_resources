class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url, :category, :location, :add_from_crunchbase
    has_many :reviews, :as => :reviewable
    has_many :partners

    validates_presence_of :description, :name, :url, :category, :location

    # default average rating to -1 so we can check for it and display "not yet rated."
    def default_values
        self.avg_rating ||= -1
        self.partners_average ||= -1
        self.num_partner_reviews ||= 0
    end

    #called whenever a new review is submitted or a review is updated on the company
    def recalculate_average(review)
    	#if no reviews have been submitted
    	if(self.avg_rating == -1)
            self.update_attribute(:avg_rating, review.rating)
        else
            companyTotal = 0
            company.reviews.each do |compReview|
                companyTotal = companyTotal + compReview.rating
            end

            partnerTotal = 0
            partnerCount = 0
            self.partners.each do |partner| 
                partner.reviews.each do |partReview|
                    partnerTotal = partnerTotal + partReview.rating
                    partnerCount = partnerCount + 1
                end
            end
 
            newAvg = (companyTotal +  partnerCount + review.rating) / (company.reviews.size + partnerCount)
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
