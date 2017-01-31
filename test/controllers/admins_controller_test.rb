require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  setup do
    @master_admin = admins(:one)
    @no_master_admin = admins(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin" do
    assert_difference('Admin.count') do
      post :create, master_admin: {email: @master_admin.email, master_admin: @master_admin.master_admin, username: @master_admin.username }
    end

    assert_redirected_to admin_path(assigns(:master_admin))
  end

  test "should show admin" do
    get :show, id: @master_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @master_admin
    assert_response :success
  end

  test "should update admin" do
    patch :update, id: @master_admin, master_admin: {email: @master_admin.email, master_admin: @master_admin.master_admin, username: @master_admin.username }
    assert_redirected_to admin_path(assigns(:master_admin))
  end

  test "should destroy admin" do
    assert_difference('Admin.count', -1) do
      delete :destroy, id: @master_admin
    end

    assert_redirected_to admins_path
  end
end
