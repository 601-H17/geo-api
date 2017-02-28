require 'test_helper'

class StairTest < ActiveSupport::TestCase

  setup do
    @point = points(:one)
  end

  test "stair should have a name, a wing and a point" do
    stair = Stair.new(name: "GE-3", wing: "G", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  # name validation

  test "stair should be invalid with name not present" do
    stair = Stair.new(name: "", wing: "G", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name can't be blank", stair.errors.full_messages[0]
  end

  test "stair should have a name unique" do
    stair1 = stairs(:one)
    stair1.point = @point

    stair2 = Stair.new(name: "GE-1", wing: "G", point: @point)

    assert stair1.valid?, stair1.errors.full_messages
    assert_not stair2.valid?, stair2.errors.full_messages
    assert_match "Name has already been taken", stair2.errors.full_messages[0]
  end

  test "stair should be invalid with a name less than 4 characters " do
    stair = Stair.new(name: "GE1", wing: "G", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is too short (minimum is 4 characters)", stair.errors.full_messages[0]
  end

  test "stair should be valid with a name with 4 characters " do
    stair = Stair.new(name: "GE-3", wing: "G", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be valid with a name more than 5 characters " do
    stair = Stair.new(name: "GE-10", wing: "G", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be invalid with a name more than 5 characters " do
    stair = Stair.new(name: "GE-100", wing: "G", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is too long (maximum is 5 characters)", stair.errors.full_messages[0]
  end

  test "stair should be invalid without proper format" do
    stair = Stair.new(name: "12345", wing: "G", point: @point)
    stair2 = Stair.new(name: "45-GE", wing: "G", point: @point)
    stair3 = Stair.new(name: "GE123", wing: "G", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Name is invalid", stair.errors.full_messages[0]
  end

  # Wing validation

  test "stair should be invalid with no wing" do
    stair = Stair.new(name: "GE-3", wing: "", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Wing can't be blank", stair.errors.full_messages[0]
  end

  test "stair should be valid with 1 letter wing" do
    stair = Stair.new(name: "GE-3", wing: "G", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be invalid with 2 letter wing" do
    stair = Stair.new(name: "GE-3", wing: "GG", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Wing is too long (maximum is 1 character)", stair.errors.full_messages[0]
  end

  test "stair should be invalid with a number wing" do
    stair = Stair.new(name: "GE-3", wing: "2", point: @point)

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Wing is invalid", stair.errors.full_messages[0]
  end

  # Point validation

  test "stair should be valid with a point" do
    stair = Stair.new(name: "GE-3", wing: "G", point: @point)

    assert stair.valid?, stair.errors.full_messages
  end

  test "stair should be invalid with no point" do
    stair = Stair.new(name: "GE-3", wing: "G")

    assert_not stair.valid?, stair.errors.full_messages
    assert_match "Point can't be blank", stair.errors.full_messages[0]
  end

end