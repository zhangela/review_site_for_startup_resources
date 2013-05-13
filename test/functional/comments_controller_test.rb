require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: {
        :discussion_id => 1,
        :body => "Great comment.",
        :user_id =>1,
        :public_name => "Angela"}
      end
    end

  end
