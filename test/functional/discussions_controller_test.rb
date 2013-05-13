require 'test_helper'

class DiscussionsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @discussion = discussions(:one)
  end

end
