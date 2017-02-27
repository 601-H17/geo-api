require 'test_helper'

class StairTest < ActiveSupport::TestCase

  setup do
    @point = points(:one)
  end

  test "stair should have a name" do
    stair = Stair.new(name: "GE-3", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  # name validation

  test "stair should be invalid with name not present" do
    stair = Stair.new(name: "", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name can't be blank", stair.errors.full_messages[0]
  end

  test "stair should have a name unique" do
    stair1 = stairs(:one)
    stair1.point = @point

    stair2 = Stair.new(name: "GE-1", point: @point)

    assert stair1.valid?, stair1.errors.full_messages
    assert_not stair2.valid?, stair2.errors.full_messages
    assert_match "Name has already been taken", stair2.errors.full_messages[0]
  end

  test "stair should be invalid with a name less than 4 characters " do
    stair = Stair.new(name: "GE1", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is too short (minimum is 4 characters)", stair.errors.full_messages[0]
  end

  test "stair should be valid with a name with 4 characters " do
    stair = Stair.new(name: "GE-3", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be valid with a name more than 5 characters " do
    stair = Stair.new(name: "GE-10", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be invalid with a name more than 5 characters " do
    stair = Stair.new(name: "GE-100", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is too long (maximum is 5 characters)", stair.errors.full_messages[0]
  end

  test "stair should be invalid without proper format" do
    stair = Stair.new(name: "12345", point: @point)
    stair2 = Stair.new(name: "45-GE", point: @point)
    stair3 = Stair.new(name: "GE123", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is invalid", stair.errors.full_messages[0]
  end

  # Point validation

  test "stair should be valid with a point" do
    stair = Stair.new(name: "GE-3", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be invalid with no point" do
    stair = Stair.new(name: "GE-3")

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Point can't be blank", stair.errors.full_messages[0]
  end

end