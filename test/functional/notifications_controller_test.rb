require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @notification = notifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notifications)
  end


  test "should create notification" do
    assert_difference('Notification.count') do
      post :create, notification: { body: @notification.body, review_id: @notification.review_id, title: @notification.title, type: @notification.type, undread: @notification.undread, user_id: @notification.user_id }
    end

    assert_redirected_to notification_path(assigns(:notification))
  end

  test "should show notification" do
    get :show, id: @notification
    assert_response :success
  end

end
