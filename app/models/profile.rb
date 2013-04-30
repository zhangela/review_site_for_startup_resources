class Profile < ActiveRecord::Base
  attr_accessible :about, :contactnum, :user_id

  belongs_to :user
end
