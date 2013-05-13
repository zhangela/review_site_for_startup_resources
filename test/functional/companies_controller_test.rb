require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase

  include Devise::TestHelpers


  setup do
    @user = users(:one)
    sign_in @user
    @company = companies(:one)
  end

  test "should get company index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get company new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { avg_rating: @company.avg_rating, description: @company.description, name: @company.name, url: @company.url }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    put :update, id: @company, company: { avg_rating: @company.avg_rating, description: @company.description, name: @company.name, url: @company.url }
    assert_redirected_to company_path(assigns(:company))
  end

end
