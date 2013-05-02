class CreateProfiles < ActiveRecord::Migration

  def change
    create_table :profiles do |t|
      t.text :about
      t.string :contactnum
      t.integer :user_id

      t.timestamps
    end
  end
end
