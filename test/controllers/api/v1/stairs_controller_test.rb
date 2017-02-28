require 'test_helper'

class Api::V1::StairsControllerTest < ActionController::TestCase

  setup do
    @stair = stairs(:one)
    @point = points(:one)
    @stair.point = @point
    @token = api_keys(:one)
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
  end

  test "should not get stairs without token" do
    @request.headers["Authorization"] = nil

    get :index

    assert_response :unauthorized
    assert_nil request.headers["Authorization"]
  end

  # Index (GET)

  test "should get stairs with token" do
    get :index

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    #assert_match @stair.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id), @response.body
  end

  # Show by name (GET by name)

  test "should get stair by name with token" do
    get :show_by_name, name: "GE-1"

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match @stair.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id).to_s, @response.body.to_s
  end

  test "should not get stair, get error 404 with token and unknown name" do
    name = "GE-10"

    get :show_by_name, name: name

    assert_response :not_found
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Stair  #{name} not found", @response.body.to_s
  end

end
