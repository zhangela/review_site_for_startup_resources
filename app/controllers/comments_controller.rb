class CommentsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :load
 
  # Load is needed so that @user is not nil(for some reason AJAX note creation does not work without it)
  def load
    @user = current_user
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @discussion = Discussion.find(params[:discussion])
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @discussion = Discussion.find(params[:discussion])
    @comment = @discussion.comments.build(params[:comment], :user_id => @user.id)

    respond_to do |format|
      if @comment.save
        @comment.create_activity :create, owner: current_user
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def createComment
    @discussion = Discussion.find(params[:discussion_id])
    @comment = @discussion.comments.build(params[:comment])
<<<<<<< HEAD
    @comment.update_attributes(:user_id => @user.id)
=======
    @comment.update_attributes(:user_id => current_user.id)
    @review = Review.find(@discussion.review_id)
>>>>>>> d4a3b75d78dfe97387533d739da73709576580b3

    respond_to do |format|
      if @comment.save
        @comment.create_activity :create, owner: current_user, key: @discussion.review_id, parameters: {title: @review.title}
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

    def getUser
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.json { render json: @user }
    end
  end
end
