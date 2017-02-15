require 'test_helper'

class TokensControllerTest < ActionController::TestCase

  setup do
    @admin = admins(:one)
    @api_key1 = api_keys(:one)
    @api_key2 = api_keys(:two)
  end

  test "get tokens index with admin already sign in" do
    session[:admin_id] = @admin.id

    get :index
    assert_response :success
  end

end
