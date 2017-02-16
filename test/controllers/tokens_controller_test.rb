require 'test_helper'

class TokensControllerTest < ActionController::TestCase

  setup do
    @admin = admins(:one)
    @api_key1 = api_keys(:one)
    @api_key2 = api_keys(:two)

    session[:admin_id] = @admin.id
  end

  test "admin not sign in access" do
    session[:admin_id] = nil

    get :index
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "get tokens index with admin already sign in" do
    get :index
    assert_response :success
    assert_match @api_key1.name, @response.body
    assert_match @api_key2.name, @response.body
  end

end
