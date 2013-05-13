require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  include Devise::TestHelpers


  setup do
    @user = users(:one)
    sign_in @user
    @profile = profiles(:one)
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile
    assert_response :success
  end

  test "should update profile" do
    put :update, id: @profile, profile: { about: @profile.about, contactnum: @profile.contactnum, user_id: @profile.user_id }
    assert_redirected_to profile_path(assigns(:profile))
  end

end
