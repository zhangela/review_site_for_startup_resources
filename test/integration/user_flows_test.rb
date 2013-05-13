require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
	fixtures :users, :companies, :comments, :discussions, :reviews, :profiles

  	test "login and view main page" do
    # login via https
    https!
    get "/users/sign_in"
    assert_response :success
 
 	# user can log in and redirects 
    post_via_redirect "/users/sign_in", 'user[email]' => 'angelaz@mit.edu', 'user[password]' => 'password' 
    assert_equal '/', path
 	
 	#Assert that companies redirect
 	get_via_redirect "/companies/1", :profile_id =>1 
    assert_response :success
    assert_equal '/companies/1', path

  end
end
