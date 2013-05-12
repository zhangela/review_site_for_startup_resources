class AddPartnersAverageToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :partners_average, :integer
  end
end
