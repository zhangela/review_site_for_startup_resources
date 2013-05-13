class AddNumPartnersReviewsToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :num_partner_reviews, :integer
  end
end
