class LoginsControllerTest < ActionController::TestCase

  setup do
    @master_admin = admins(:one)
    @no_master_admin = admins(:two)
  end

  test "should sucess if connect" do
    session[:admin_id] = @master_admin.id
    get :new
    assert_response :redirect
  end

  test "should stay on page if error happens" do
    get :new
    assert_response :success
  end

  test "should destroy admin" do
    delete :destroy, id: @master_admin
    assert_response :redirect
  end

end