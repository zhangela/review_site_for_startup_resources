class ProfilesController < ApplicationController
  before_filter :authenticate_user!

  before_filter :load
  respond_to :html, :json
 


  # Load is needed so that @user is not nil
  def load
    @user = current_user
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
    @users = User.find(current_user.id)
    @comments = Comment.where( :user_id => @user.id).take(3)

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
    @profile.update_attributes(params[:profile])
    respond_with @profile
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
