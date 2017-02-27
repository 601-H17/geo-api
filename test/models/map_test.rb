require 'test_helper'

class MapTest < ActiveSupport::TestCase

  test "map should have a name and a floor" do
    map = Map.new(name: "map 1", floor: 1)
    assert map.valid?, map.errors.full_messages
  end

  test "map should be invalid with name not present" do
    map = Map.new
    assert_not map.valid?, map.errors.full_messages
    assert_match "Name can't be blank", map.errors.full_messages[0]
  end

  test "map should be invalid with name not unique (case sensitive)" do
    map_name = "map 1"
    error_message = "Name has already been taken"
    already_registered_map = Map.new(name: map_name, floor: 1)
    already_registered_map.save

    first_map = Map.new(name: map_name, floor: 1)
    second_map = Map.new(name: map_name, floor: 1)

    assert_not first_map.valid?, first_map.errors.full_messages
    assert_match error_message, first_map.errors.full_messages[0]
    assert_not second_map.valid?, second_map.errors.full_messages
    assert_match error_message, second_map.errors.full_messages[0]
  end

  test "map should be invalid with name too short (less than 3)" do
    map = Map.new(name: "a", floor: 1)

    assert_not map.valid?, map.errors.full_messages
    assert_match "Name is too short (minimum is 3 characters)", map.errors.full_messages[0]
  end

  test "map should be invalid with name too long (more than 150)" do
    map = Map.new(name: "a" * 150, floor: 1)

    assert_not map.valid?, map.errors.full_messages
    assert_match "Name is too long (maximum is 15 characters)", map.errors.full_messages[0]
  end

  test "map should should be invalid with floor not present" do
    map = Map.new
    assert_not map.valid?, map.errors.full_messages
    assert_match "Floor can't be blank", map.errors.full_messages[2]
  end

  test "map should should be invalid with floor greater than 4" do
    map = Map.new(name: "aaa", floor: 5)

    assert_not map.valid?, map.errors.full_messages
    assert_match "Floor must be less than 4", map.errors.full_messages[0]
  end

  test "map should should be invalid with floor smaller than 0" do
    map = Map.new(name: "aaa", floor: -4)

    assert_not map.valid?, map.errors.full_messages
    assert_match "Floor must be greater than 0", map.errors.full_messages[0]
  end

end
