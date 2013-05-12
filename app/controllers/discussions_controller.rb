class DiscussionsController < ApplicationController

  # POST /discussions
  # creates a new discussion that belongs to a particular review
  # a discussion is simply an object that holds a list of comments,
  # when a user creates a discussion, s/he is really creating the first comment in that dicussion
  def create

    # a discussion belongs to a review
    @review = Review.find(params[:review_id])
    @discussion = @review.discussions.build(params[:discussion])

    # from_user_id is the user who  posted the dicussion
    @discussion.from_user_id = current_user.id

    # to_user_id is the user who posted the review
    @discussion.to_user_id = @review.user_id

    # when the user chooses to post anonymous review, the public_name of this discussion,
    # which is the displayed name shown to all users, will be "Anonymous"
    anonymous = params[:anonymous]
    if(anonymous)
      public_name = "Anonymous"
    else
      public_name = current_user.name
    end

    # when a user "creates a discussion," s/he is creating the first comment in that dicussion
    @comment = @discussion.comments.build(:body=>params[:body], :user_id=> current_user.id, :public_name=>public_name)

    respond_to do |format|
      if @discussion.save

        # saves this discussoin create event to the list of notifications.
        @notification = Notification.new(user_id: current_user, user_name: current_user.name, notify:"d", review_id: @discussion.review_id, title:@review.title,)
        @notification.save

        # dicussion is created
        format.json { render json: @review, status: :created, location: @review }
        format.html { redirect_to @review}
      else

        # discussion is not created, renders new with error
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
end
