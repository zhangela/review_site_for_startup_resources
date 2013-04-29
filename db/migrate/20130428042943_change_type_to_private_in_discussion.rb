class ChangeTypeToPrivateInDiscussion < ActiveRecord::Migration
  def change
  	
  	add_column :discussions, :private, :boolean
  end
end
