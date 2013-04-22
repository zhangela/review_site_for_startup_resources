class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.decimal :avg_rating
      t.string :url

      t.timestamps
    end
  end
end
