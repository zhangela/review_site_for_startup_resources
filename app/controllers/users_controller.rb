class UsersController < Devise::SessionsController
  # Creates a profile automatically when a user is created
  def build_profile
        @user.build_profile
        @user.profile.user_id = current_user.id
        puts "built"
        @user.save!
    end
  def create
  	super
  	@user = User.create( params[:user] )
  end
  def show
  	@user = User.find(current_user.id)
  end

end