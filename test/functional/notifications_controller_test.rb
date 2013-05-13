require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @notification = notifications(:one)
  end
end
