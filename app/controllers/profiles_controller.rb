class ProfilesController < ApplicationController

  # must first authentication user
  before_filter :authenticate_user!

  # load current user
  before_filter :load

  respond_to :html, :json

  # Load is needed so that @user is not nil
  def load
    @user = current_user
  end

  # GET /profiles/1
  # Shows a specific profile that belongs to a current user
  def show
    @profile = Profile.find(params[:id])
    @user = User.find(params[:id])
    @comments = Comment.where( :user_id => @user.id).take(3)

    respond_to do |format|
      format.html # show.html.erb
      format.json { respond_with_bip(@profile) }
    end
  end

  # GET /profiles/1/edit
  # Shows the edit page for the current_user's profile
  def edit
    @profile = Profile.find(current_user.id)
  end

  # POST /profiles
  # Creates the current_user's profile
  def create
    # Buidles a profile in association witht eh user
    @user = User.find(current_user.id)
    @profile = @user.build_profile(params[:user])
    @profile.update_attributes(params[:profile])

    respond_to do |format|
      if @profile.save
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # Updates the current_user's profile
  def update
    @profile = Profile.find(current_user.id)
    @profile.update_attributes(params[:profile])
    respond_with @profile
  end


end
