class ActivitiesController < ApplicationController
	
  def index
  	@activities = PublicActivity::Activity.order("created_at desc") 	
  	
  end

  def read
  	@activities = PublicActivity::Activity.all
  
  	@activities.each do |activity|
  		title = activity.parameters[:title]
  		activity.update_attributes(:parameters => {:title => title, :read => true})
  	end 

  	redirect_to root_url
  end

end
