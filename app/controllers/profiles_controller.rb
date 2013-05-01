class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :load
  respond_to :json
 
  # Load is needed so that @user is not nil(for some reason AJAX note creation does not work without it)
  def load
    @user = current_user
  end

  # Helper method to allow in-place editing of ntoe
  def in_place_update
     @profile = Profile.find(params[:id])
     @profile.update_attributes(:name, params[:text])

     respond_to do |format|
      format.js
     end
  end
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    puts "hi"
    puts @profile.user_id
    @users = User.find(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { respond_with_bip(@profile) }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.json
  def create
    # Buidles a profile in association witht eh user
    @user = User.find(current_user.id)
    @profile = @user.build_profile(params[:user])
    @profile.update_attributes(params[:profile])
    puts "in create"
    p @profile.picture_url

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end
