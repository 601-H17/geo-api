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

  # New (GET)

  test "get classrooms new" do
    get :new
    assert_response :success
    assert_template :new
  end

end