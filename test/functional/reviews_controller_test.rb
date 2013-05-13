require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @review = reviews(:one)
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, {review: { body: @review.body, rating: @review.rating, pros: @review.pros, cons: @review.cons, reviewable_id: 1, reviewable_type: @review.reviewable_type, title: @review.title }, review_id: 1, reviewable_id: 1}
    end

    assert_redirected_to review_path(assigns(:review))
  end

  test "should get edit" do
    get :edit, id: @review.id
    assert_response :success
  end

  test "should update review" do
    put :update, id: @review.id, review: { body: @review.body,  pros: @review.pros, cons: @review.cons, rating: @review.rating, reviewable_id: 1, reviewable_type: @review.reviewable_type, title: @review.title }
    assert_redirected_to review_path(assigns(:review))
  end

end