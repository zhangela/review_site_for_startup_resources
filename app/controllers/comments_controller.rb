class CommentsController < ApplicationController

  # require authentication and loading current_user before displaying info
  before_filter :authenticate_user!, :load

  # loads the current_user
  def load
    @user = current_user
  end

  # creates new comment that belongs to a discussion
  def createComment
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.build(params[:comment])

    # public_name is the displayed name for all comments.
    # if the user chooses to post a comment anonymously, the public_name will be set to "Anonymous"
    # otherwise, the public_name will be the user's name
    anonymous = params[:anonymous]
    if(anonymous == "true")
      public_name = "Anonymous"
    else
      public_name = @user.name
    end

    #saves the public_name
    @comment.update_attributes(:user_id => current_user.id, :public_name => public_name)

    @review = Review.find(@discussion.review_id)

    respond_to do |format|
      if @comment.save

        # adds this comment creation to the list of all notifications
        @notification = Notification.new(user_id: current_user.id, user_name: current_user.name, notify:"c", review_id: @discussion.review_id, title:@review.title,)
        @notification.save
        format.json { render json: @comment, status: :created, location: @comment }

      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

    # called in JS. returns the user object for a comment (needed to display @user.name)
    def getUser
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.json { render json: @user }
    end
  end
end
