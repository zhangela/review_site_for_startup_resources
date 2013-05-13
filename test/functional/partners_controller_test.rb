require 'test_helper'

class PartnersControllerTest < ActionController::TestCase

  include Devise::TestHelpers


  setup do
    @user = users(:one)
    sign_in @user
    @partner = partners(:one)
    @company = companies(:one)
    @company.save
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post :create, {partner: { avg_rating: @partner.avg_rating, name: @partner.name, company_id: 1, email: @partner.email }, company_id: 1}
    end

    assert_redirected_to partner_path(assigns(:partner))
  end

  test "should show partner" do
    get :show, id: @partner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @partner
    assert_response :success
  end

  test "should update partner" do
    put :update, id: @partner, partner: { avg_rating: @partner.avg_rating, name: @partner.name, company_id: 1, email: @partner.email }
    assert_redirected_to partner_path(assigns(:partner))
  end

end