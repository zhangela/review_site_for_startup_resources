class AddLocationColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :location, :string
  end
end
