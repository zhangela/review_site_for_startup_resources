class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.decimal :avg_rating

      t.timestamps
    end
  end
end
