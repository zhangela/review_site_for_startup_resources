class AddCrunchbaseColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :add_from_crunchbase, :boolean
  end
end
