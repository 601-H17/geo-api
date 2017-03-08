require 'test_helper'

class MapControllerTest < ActionController::TestCase

  setup do
    @master_admin = admins(:one)
    @no_master_admin = admins(:two)
  end

  test "should display the map when connected" do
    session[:admin_id] = @master_admin.id
    get :display
    assert_response :success
  end

  test "should redirect when not connected" do
    get :display
    assert_response :redirect
  end

end
