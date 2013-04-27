class DiscussionThreadsController < ApplicationController
  # GET /discussion_threads
  # GET /discussion_threads.json
  def index
    @discussion_threads = DiscussionThread.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discussion_threads }
    end
  end

  # GET /discussion_threads/1
  # GET /discussion_threads/1.json
  def show
    @discussion_thread = DiscussionThread.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @discussion_thread }
    end
  end

  # GET /discussion_threads/new
  # GET /discussion_threads/new.json
  def new
    @discussion_thread = DiscussionThread.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @discussion_thread }
    end
  end

  # GET /discussion_threads/1/edit
  def edit
    @discussion_thread = DiscussionThread.find(params[:id])
  end

  # POST /discussion_threads
  # POST /discussion_threads.json
  def create
    @discussion_thread = DiscussionThread.new(params[:discussion_thread])

    respond_to do |format|
      if @discussion_thread.save
        format.html { redirect_to @discussion_thread, notice: 'Discussion thread was successfully created.' }
        format.json { render json: @discussion_thread, status: :created, location: @discussion_thread }
      else
        format.html { render action: "new" }
        format.json { render json: @discussion_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /discussion_threads/1
  # PUT /discussion_threads/1.json
  def update
    @discussion_thread = DiscussionThread.find(params[:id])

    respond_to do |format|
      if @discussion_thread.update_attributes(params[:discussion_thread])
        format.html { redirect_to @discussion_thread, notice: 'Discussion thread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussion_threads/1
  # DELETE /discussion_threads/1.json
  def destroy
    @discussion_thread = DiscussionThread.find(params[:id])
    @discussion_thread.destroy

    respond_to do |format|
      format.html { redirect_to discussion_threads_url }
      format.json { head :no_content }
    end
  end
end
