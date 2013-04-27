class ReviewsController < ApplicationController

  before_filter :load_reviewable
  before_filter :authenticate_user!
  
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @reviewable.reviews

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])
    @discussions = @review.discussions
    @discussion = Discussion.new


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = @reviewable.reviews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review =  @reviewable.reviews.build(:title=>params[:review][:title], :body=>params[:review][:body], :rating=>params[:rating])
    @reviewable.recalculate_average(@review)


    respond_to do |format|
      if @review.save
        format.html { redirect_to @reviewable, notice: 'Review was successfully created.' }
        format.json { render json: @reviewable, status: :created, location: @reviewable }
      else
        format.html { render action: "new" }
        format.json { render json: @reviewable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

def load_reviewable
    resource, id = request.path.split('/')[1, 2]
    @reviewable = resource.singularize.classify.constantize.find(id)
  end

end
