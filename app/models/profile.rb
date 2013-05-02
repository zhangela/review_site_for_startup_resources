class Profile < ActiveRecord::Base
  attr_accessible :about, :contactnum, :user_id, :picture_url

  belongs_to :user
end
