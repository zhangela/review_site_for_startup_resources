class Profile < ActiveRecord::Base
  attr_accessible :about, :contactnum, :user_id, :picture_url

  belongs_to :user
  before_create :default_values


  private

  def default_values
    self.about ||= "Double click me to edit!"
    self.contactnum |= "Enter your contact info"
  end
end
