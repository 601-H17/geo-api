class UploadControllerTest < ActionController::TestCase

  setup do
    @admin = admins(:one)
    @map_1 = maps(:one)
    @map_2 = maps(:two)

    session[:admin_id] = @admin.id
  end

  test "get upload index" do
    get :index
    assert_response :success
    assert_template :index
    assert_match @map_1.name, @response.body
    assert_match @map_2.name, @response.body
  end

  test "should upload map" do
    map_name = "floor 1"
    assert_difference('Map.count') do
      post :create, map: {name: map_name}
    end

    assert_response :redirect
    assert_redirected_to upload_index_path
    assert_not_nil Map.find_by_name(map_name)
  end

  test "should update map name" do
    map_name = "floor 2"

    put :update, id: @map_1, map: {name: map_name}

    assert_response :redirect
    assert_redirected_to upload_index_path
  end

  test "should delete map" do
    new_map = Map.create!(name: "floor 1")

    assert_difference('Map.count', -1) do
      delete :destroy, id: new_map, map: new_map
    end

    assert_response :redirect
    assert_redirected_to upload_index_path
    assert_raises ActiveRecord::RecordNotFound do
      Map.find(new_map.id)
    end
  end

  test "should render new page" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should get edit page for map" do
    get :edit, id: @map_1.id
    assert_response :success
    assert_template :edit
    assert_match @map_1.name, @response.body
  end

end