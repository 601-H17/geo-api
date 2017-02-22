require 'test_helper'

class Api::V1::CorridorsControllerTest < ActionController::TestCase

  test "should get corridors json" do
    get :index

    assert_response :success
  end

end
