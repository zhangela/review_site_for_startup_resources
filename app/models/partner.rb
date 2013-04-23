class Partner < ActiveRecord::Base
    belongs_to :company
    has_many :reviews, :as => :reviewable

    attr_accessible :avg_rating, :name

    before_save :default_values

    def default_values
        self.avg_rating ||= -1
    end
end