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

    #called whenever a new review is submitted or a review is updated on the company
    def recalculate_average()

        #find the company's total by iterating through all reviews
        companyTotal = 0
        self.reviews.each do |compReview|
            companyTotal = companyTotal + compReview.rating
        end

        #find the partner's total score by iterating through all partners and all reviews
        partnerTotal = 0
        partnerCount = 0
        self.partners.each do |partner| 
            partner.reviews.each do |partReview|
                partnerTotal = partnerTotal + partReview.rating
                partnerCount = partnerCount + 1
            end
        end

        #must be float to account for remainder
        newAvg = (companyTotal +  partnerTotal).to_f / (self.reviews.size + partnerCount)
  		self.update_attribute(:avg_rating, newAvg)
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
