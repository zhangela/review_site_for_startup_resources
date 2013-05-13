require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  include Devise::TestHelpers


  setup do
    @comment = comments(:one)
    @user = users(:one)
    @discussion = discussions(:one)
    sign_in @user
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :createComment, {comment: {
        :discussion_id => 1,
        :body => "Great comment.",
        :user_id =>1,
        :public_name => "Angela",
        :id =>1,}, discussion_id: @comment.discussion_id}
      end
    end

  end
