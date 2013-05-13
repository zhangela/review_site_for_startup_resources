class Profile < ActiveRecord::Base
  attr_accessible :about, :contactnum, :user_id, :picture_url

  belongs_to :user
  before_create :default_values


  private

    # default values to be displayed on the profile page
  def default_values
    self.about ||= "Nothing yet!"
    self.contactnum = "No phone number on file :("
  end
end
