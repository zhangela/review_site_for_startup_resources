class CreatePartners < ActiveRecord::Migration
  def change

    create_table :partners do |t|
      t.string :name
      t.decimal :avg_rating
      t.references :company

      t.timestamps
    end
    add_index :partners, :company_id
  end
end
