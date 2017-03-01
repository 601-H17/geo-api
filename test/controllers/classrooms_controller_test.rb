require 'test_helper'

class ClassroomsControllerTest < ActionController::TestCase

  setup do
    @admin = admins(:one)
    @classroom1 = classrooms(:one)
    @classroom2 = classrooms(:two)
    session[:admin_id] = @admin.id
  end

  test "should redirect to root when admin is not sign in" do
    session[:admin_id] = nil

    get :index
    assert_response :redirect
    assert_redirected_to root_path
  end

  # Index (GET)

  test "get classrooms index" do
    get :index

    assert_response :success
    assert_template :index
    assert_match @classroom1.name, @response.body
    assert_match @classroom2.name, @response.body
  end

  # Create (POST)

  test "should create classroom with name, floor, wing and point" do
    name, floor, wing, lat, lng = "A-001", 1, "A", 2.0, 1.0

    assert_difference('Classroom.count') do
      post :create, classroom: { name: name, floor: floor, wing: wing, point_attributes: { lat: lat, lng: lng } }
    end

    assert_response :redirect
    assert_redirected_to classrooms_path
    assert_not_nil Classroom.find_by_name(name)
  end

  test "should not create with invalid params" do
    name, floor, wing, lat, lng = "A-", 1, "A", 1, 1

    assert_no_difference('Classroom.count') do
      post :create, classroom: { name: name, floor: floor, wing: wing, point_attributes: { lat: lat, lng: lng } }
    end

    assert_template :new
    assert_nil Classroom.find_by_name(name)
  end

  # Update (PUT PATCH)

  test "should update classroom name" do
    point = Point.create(lat: 0, lng: 0)
    classroom = Classroom.create(name: "A-001", wing: "A", floor: 1, point: point)
    new_classroom_name, new_lat = "A-101", 120

    put :update , id: classroom, classroom: { name: new_classroom_name, point_attributes: { lat: new_lat } }

    classroom1 = Classroom.find(classroom.id)
    assert_response :redirect
    assert_redirected_to classrooms_path
    assert_equal new_classroom_name, classroom1.name
    assert_equal Point.new(lat: new_lat).lat, classroom1.point.lat
  end

  test "should not update classroom name" do
    point = Point.create(lat: 0, lng: 0)
    classroom = Classroom.create(name: "A-001", wing: "A", floor: 1, point: point)
    new_classroom_name, new_lat = "Classroom update not so valid", 120

    put :update , id: classroom, classroom: { name: new_classroom_name, point_attributes: { lat: new_lat } }

    assert_template :edit
  end

  # New (GET)

  test "get classrooms new" do
    get :new
    assert_response :success
    assert_template :new
  end

  # Edit (GET)

  test "get classrooms edit" do
    get :edit, id: @classroom1.id

    assert_response :success
    assert_template :edit
    assert_match @classroom1.name, @response.body
  end

end