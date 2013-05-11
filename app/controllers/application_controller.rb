class ApplicationController < ActionController::Base
  protect_from_forgery

  # calls the notifications method to load notifications in the navbar
  before_filter :notifications

  helper_method :count

  private

  	# loads relevant notifications for the current_user in the navbar
	def notifications
		@num_unread = 0
		if current_user
		  @notifications = Notification.unread_by(current_user)
		  @relevant_notifications = []

		  @notifications.each do |notification|

		  	# only shows notifications not caused by current user
		  	if notification.user_id != current_user.id

		  		# loads the list of relevant users (who should be notified) for this notification
			  	@relevant_users = []
			  	@review = Review.find(notification.review_id)
			  	@review.discussions.each do |discussion|
			  		discussion.comments.each do |comment|
			  			@relevant_users << comment.user_id
			  		end
			  	end

			  	# only shows notifications that are relevant to the current_user
			  	# relavance is defined by the user having commented on a particular discussion
			  	if @relevant_users.include? current_user.id
				  		@relevant_notifications << notification
				  		@num_unread = @num_unread + 1
			  	end
			end
		  end
		end
	end
end
