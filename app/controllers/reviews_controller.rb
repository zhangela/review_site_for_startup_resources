class ReviewsController < ApplicationController

  before_filter :load_reviewable
  before_filter :authenticate_user!

  # GET all reviews that belong to a company or partner
  def index
    @reviews = @reviewable.reviews

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET a particular review and show its discussions and comments
  def show
    @review = Review.find(params[:id])
    @discussions = @review.discussions
    @discussion = Discussion.new
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET form for creating a review
  def new
    @review = @reviewable.reviews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  # GET review edit form
  def edit
    @review = Review.find(params[:id])
  end

  #checks if @reviewable is type partner.
  #If partner, must recalculate partner and total average in the partner's company 
  def recalculate_averages
    if @reviewable.kind_of? Partner
        @company = @reviewable.company
        @company.recalculate_partners_average(@review) #total partner average
    end
    @reviewable.recalculate_average(@review)
  end

  # POST /reviews
  # POST review creation
  def create
    # @reviewable could be either a company or a partner
    @review =  @reviewable.reviews.build(:title=>params[:review][:title], :body=>params[:review][:body], :rating=>params[:rating], :user_id=>current_user.id)
    
    recalculate_averages

    anonymous = params[:anonymous]
    if(anonymous)
      public_name = "Anonymous"
    else
      public_name = current_user.name
    end

    @review.update_attributes(:public_name => public_name)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @reviewable}
        format.json { render json: @reviewable, status: :created, location: @reviewable }
      else
        format.html { render action: "new" }
        format.json { render json: @reviewable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # Update the review after submitting edit form.
  def update
    @review = Review.find(params[:id])

    # update the review average for the firm and the partner
    @reviewable.recalculate_average(@review)

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

# load the reviewable, either company or partner
def load_reviewable
    resource, id = request.path.split('/')[1, 2]
    @reviewable = resource.singularize.classify.constantize.find(id)
  end

end
