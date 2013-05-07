class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :notifications
  helper_method :count

  private
	def notifications
		if current_user
		  @notifications = Notification.unread_by(current_user)
		  @num_unread = count 
		 end
	end

	def count
	  	count = 0
	  	@notifications = Notification.all
	  	@notifications.each do |notification|
	  		if notification.unread?(current_user)
	  			count = count + 1
	  		end
	  	end
	  	return count 
  	end
end
