class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :notifications
  helper_method :count

  private
	def notifications
		@num_unread = 0
		if current_user
		  @notifications = Notification.unread_by(current_user)
		  @relevant_notifications = []

		  @notifications.each do |notification|
		  	if notification.user_id != current_user.id
		  		puts notification.user_id
		  		puts current_user.id
			  	@relevant_users = []
			  	@review = Review.find(notification.review_id)
			  	@review.discussions.each do |discussion|
			  		discussion.comments.each do |comment|
			  			@relevant_users << comment.user_id
			  		end
			  	end
			  	if @relevant_users.include? current_user.id 
				  		@relevant_notifications << notification
				  		@num_unread = @num_unread + 1
			  	end 
			end
		  end
		end
	end
end
