class RegistrationsController < Devise::RegistrationsController
	# Creates a profile automatically when a user is created
  def build_profile
        @user.build_profile
        @user.profile.user_id = current_user.id
        puts "built"
        @user.save!
    end
end
