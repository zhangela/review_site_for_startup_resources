class ApplicationController < ActionController::Base
  protect_from_forgery

  include PublicActivity::StoreController
  before_filter :notifications
  helper_method :count

  private
	def notifications
	  @activities = PublicActivity::Activity.order("created_at desc")
	  @num_unread = count 
	end

	def count
  	count = 0
  	@activities = PublicActivity::Activity.all
  	@activities.each do |activity|
  		if !activity.parameters[:read]
  			count = count + 1
  		end
  	end
  	p "coutn is"
  	puts count
  	return count 
  end
end
