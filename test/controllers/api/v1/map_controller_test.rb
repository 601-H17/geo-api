require 'test_helper'

class Api::V1::MapControllerTest < ActionController::TestCase

  setup do
    @token = api_keys(:one)
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
  end

  # Index (GET /map)

  test "should not get map without token" do
    @request.headers["Authorization"] = nil

    get :index

    assert_response :unauthorized
    assert_nil request.headers["Authorization"]
  end

  test "should get map with token" do
    get :index

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
  end

  # Map2 (GET /map2)

  test "should get map2 with token" do
    get :map2

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
  end

end