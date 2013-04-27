class AddCategoryIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :category_id, :integer
  end
end
