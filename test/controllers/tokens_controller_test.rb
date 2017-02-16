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

  # Index (GET)

  test "get tokens index" do
    get :index
    assert_response :success
    assert_template :index
    assert_match @api_key1.name, @response.body
    assert_match @api_key2.name, @response.body
  end

  # Create (POST)

  test "should create token with name" do
    api_key_name = "my api"
    assert_difference('ApiKey.count') do
      post :create, api_key: { name: api_key_name }
    end

    assert_response :redirect
    assert_redirected_to tokens_path
    assert_not_nil ApiKey.find_by_name(api_key_name)
  end

  test "should not create with invalid name admin" do
    api_key_name = "my not so valid api token"

    assert_no_difference('ApiKey.count') do
      post :create, api_key: { name: api_key_name }
    end

    assert_template :new
  end

  # Update (PUT PATCH)

  test "should update token name" do
    new_apikey_name = "Api key update"

    put :update , id: @api_key1, api_key: { name: new_apikey_name }

    assert_response :redirect
    assert_redirected_to tokens_path
  end

  test "should not update token name" do
    new_apikey_name = "Api key update not so valid"

    put :update , id: @api_key1, api_key: { name: new_apikey_name }

    assert_template :edit
  end

  # Destroy (DELETE)

  test "should destroy token" do
    new_token = ApiKey.create!(name: "valid key")

    assert_difference('ApiKey.count', -1) do
      delete :destroy, id: new_token, api_key: new_token
    end

    assert_response :redirect
    assert_redirected_to tokens_path
    assert_raises ActiveRecord::RecordNotFound do
      ApiKey.find(new_token.id)
    end
  end

end
