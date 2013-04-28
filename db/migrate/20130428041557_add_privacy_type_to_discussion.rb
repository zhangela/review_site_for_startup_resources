class AddPrivacyTypeToDiscussion < ActiveRecord::Migration
  def change
  	add_column :discussions, :type, :string
  end
end
