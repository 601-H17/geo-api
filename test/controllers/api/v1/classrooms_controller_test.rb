require 'test_helper'

class Api::V1::ClassroomsControllerTest < ActionController::TestCase

  setup do
    @classroom = classrooms(:one)
    @token = api_keys(:one)
    @request.headers["Authorization"] = "Token token=#{@token.access_token}"
  end

  test "should not get classrooms without token" do
    @request.headers["Authorization"] = nil

    get :index

    assert_response :unauthorized
    assert_nil request.headers["Authorization"]
  end

  # Index (GET)

  test "should get classrooms with token" do
    get :index

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match @classroom.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id).to_s, @response.body.to_s
  end

  # Show (GET by id)

  test "should get classroom by id with token" do
    get :show, id: @classroom.id

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match @classroom.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id).to_s, @response.body.to_s
  end

  test "should not get classroom by id with invalid id" do
    invalid_id = 100000000

    get :show, id: invalid_id

    assert_response :not_found
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Classroom with id \\u003c#{invalid_id}\\u003e not found", @response.body
  end

  # Show by name (GET by name)

  test "should get classroom by name with token" do
    get :show_by_name, name: "MyString1"

    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match @classroom.to_json(include: { point: {only: [:lat, :lng]} }, except: :point_id).to_s, @response.body.to_s
  end

  test "should not get classrooms, get error 404 with token and unknown name" do
    name = "MyString"

    get :show_by_name, name: name

    assert_response :not_found
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Classroom #{name} not found", @response.body.to_s
  end

  # Search by name (GET from a substring)

  test "should get classrooms from query by name (uppercase) with token" do
    get :search_by_name, query: "M"

    classrooms = JSON.parse @response.body
    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_equal 2, classrooms.count
  end

  test "should get classrooms from query by name (downcase) with token" do
    get :search_by_name, query: "m"

    classrooms = JSON.parse @response.body
    assert_response :success
    assert_includes request.headers["Authorization"], @token.access_token
    assert_equal 2, classrooms.count
  end

  test "should not get classrooms from query, get error 404 with token and unknown name" do
    query = "C"

    get :search_by_name, query: query

    assert_response :not_found
    assert_includes request.headers["Authorization"], @token.access_token
    assert_match "Classroom(s) #{query} not found", @response.body.to_s
  end

end