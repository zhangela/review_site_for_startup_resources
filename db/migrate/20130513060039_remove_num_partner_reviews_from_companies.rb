class RemoveNumPartnerReviewsFromCompanies < ActiveRecord::Migration
  def change
  	remove_column :companies, :partners_average
  	remove_column :companies, :num_partner_reviews
  end
end
