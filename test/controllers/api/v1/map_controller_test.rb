class Api::V1::MapControllerTest < ActionController::TestCase

  setup do
    @token = api_keys(:one)
  end

  test "should get map with token" do
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
    get :index
    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
  end

  test "should not get map without token" do
    get :index
    assert_response :unauthorized
  end

end