class RemovePosterEmailFromComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :poster_email, :string
  end
end
