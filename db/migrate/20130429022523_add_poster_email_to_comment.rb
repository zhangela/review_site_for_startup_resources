class AddPosterEmailToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :poster_email, :string
  end
end
