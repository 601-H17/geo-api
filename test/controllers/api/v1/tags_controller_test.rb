require 'test_helper'

class Api::V1::TagsControllerTest < ActionController::TestCase

  setup do
    @tag = tags(:one)
    @classroom = classrooms(:one)
    @master_admin = admins(:one)
    session[:admin_id] = @master_admin.id
  end

  test "should not get all tags when not signed in" do
    session[:admin_id] = nil

    get :get_tags, id: @classroom.id

    assert_response :redirect
    assert_redirected_to root_path
  end

  # GET tags

  test "should get tags for a classroom" do
    @classroom.tags << @tag

    get :get_tags, id: @classroom.id

    assert_response :success
    assert_match @tag.name, @response.body
  end

  # POST save tags for classroom

  test "should save tags for a classroom with existing tag" do
    post :save_for_classroom, id: @classroom.id, tags: {"0" => {"tag" => @tag.name}}

    assert_response :success
    assert_equal @tag.name, @classroom.tags[0].name
  end

  test "should save tags for a classroom with new tag" do
    tag_name = "New tag"

    post :save_for_classroom, id: @classroom.id, tags: {"0" => { tag: tag_name }}

    assert_response :success
    assert_equal tag_name, @classroom.tags[0].name
    assert_equal Tag.all.count, 2
  end

  # DELETE tag

  test "should remove a tag from a classroom" do
    @classroom.tags << @tag

    delete :delete_tag, id: @classroom.id, tag: @tag.name

    assert_response :success
    assert_equal @classroom.tags.count, 0
    assert_equal Tag.all.count, 1
  end

end