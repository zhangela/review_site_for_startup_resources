require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @review = reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, review: { body: @review.body, rating: @review.rating, reviewable_id: @review.reviewable_id, reviewable_type: @review.reviewable_type, title: @review.title }
    end

    assert_redirected_to review_path(assigns(:review))
  end

  test "should show review" do
    get :show, id: @review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @review
    assert_response :success
  end

  test "should update review" do
    put :update, id: @review, review: { body: @review.body, rating: @review.rating, reviewable_id: @review.reviewable_id, reviewable_type: @review.reviewable_type, title: @review.title }
    assert_redirected_to review_path(assigns(:review))
  end

  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete :destroy, id: @review
    end

    assert_redirected_to reviews_path
  end
end
