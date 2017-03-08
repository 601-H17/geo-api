require 'test_helper'

class Api::V1::CorridorsControllerTest < ActionController::TestCase

  setup do
    @token = api_keys(:one)
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
  end

  test "should not get without token" do
    @request.headers["Authorization"] = nil

    get :index

    assert_response :unauthorized
    assert_nil request.headers["Authorization"]
    assert_equal "HTTP Token: Access denied.\n", @response.body
  end

  # test "should get corridors json" do
  #   get :index
  #
  #   assert_response :success
  #   assert_includes request.headers["Authorization"], @token.access_token
  # end

end
