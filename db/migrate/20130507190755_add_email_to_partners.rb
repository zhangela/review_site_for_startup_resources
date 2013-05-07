class AddEmailToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :email, :string
  end
end
