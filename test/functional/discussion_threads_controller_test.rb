require 'test_helper'

class DiscussionThreadsControllerTest < ActionController::TestCase
  setup do
    @discussion_thread = discussion_threads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:discussion_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discussion_thread" do
    assert_difference('DiscussionThread.count') do
      post :create, discussion_thread: {  }
    end

    assert_redirected_to discussion_thread_path(assigns(:discussion_thread))
  end

  test "should show discussion_thread" do
    get :show, id: @discussion_thread
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @discussion_thread
    assert_response :success
  end

  test "should update discussion_thread" do
    put :update, id: @discussion_thread, discussion_thread: {  }
    assert_redirected_to discussion_thread_path(assigns(:discussion_thread))
  end

  test "should destroy discussion_thread" do
    assert_difference('DiscussionThread.count', -1) do
      delete :destroy, id: @discussion_thread
    end

    assert_redirected_to discussion_threads_path
  end
end
