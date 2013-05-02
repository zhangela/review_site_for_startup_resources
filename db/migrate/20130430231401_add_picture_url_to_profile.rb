class AddPictureUrlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :picture_url, :string
  end
end
