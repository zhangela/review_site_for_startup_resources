class Company < ActiveRecord::Base
    before_save :default_values

    attr_accessible :avg_rating, :description, :name, :url
    has_many :reviews, :as => :reviewable
    has_many :partners

      def default_values
        self.avg_rating ||= -1
    end

end
