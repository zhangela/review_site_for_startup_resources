class ChangeTypeToPrivateInDiscussion < ActiveRecord::Migration
  def change
  	remove_column :discussions, :type, :string
  	add_column :discussions, :private, :boolean
  end
end
