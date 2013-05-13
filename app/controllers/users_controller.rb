class UsersController < Devise::SessionsController

  # Creates a profile automatically when a user is created
  def build_profile
        @user.build_profile
        @user.profile.user_id = current_user.id
        @user.profile.contactnum = "No phone number on file :("
        @user.save!
    end

  # creates the user. calls super method as part of the Devise gem
  def create
  	super
  	@user = User.create( params[:user] )
  end

  # shows the user
  def show
  	@user = User.find(current_user.id)
  end

end