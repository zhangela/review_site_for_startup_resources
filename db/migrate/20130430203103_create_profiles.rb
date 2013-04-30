class CreateProfiles < ActiveRecord::Migration

  def change
  	drop_table :profiles
    create_table :profiles do |t|
      t.text :about
      t.string :contactnum
      t.integer :user_id

      t.timestamps
    end
  end
end
