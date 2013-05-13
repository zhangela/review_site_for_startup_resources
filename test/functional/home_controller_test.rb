require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test "should get index" do
    @user = users(:one)
    sign_in @user
    get :index
    assert_response :success
end

end
