require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase

  DEFAULT_FLOOR = 1

  setup do
    @point = points(:one)
  end

  test "classroom should have name and description" do
    classroom = Classroom.new(name: "G-164", description: "A description", wing: "G", floor: 1, point: @point)
    assert classroom.valid?, classroom.errors.full_messages
  end

  # name validations

  test "classroom should be invalid with name not present" do
    classroom = Classroom.new(name: "", description: "A description", wing: "G", floor: 1, point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Name can't be blank", classroom.errors.full_messages[0]
  end

  test "classroom should be invalid with name not unique (case sensitive)" do
    classroom1 = classrooms(:one)
    classroom1.point = @point

    classroom2 = Classroom.new(name: classroom1.name, description: "A description", floor: 1, wing: "G", point: @point)

    assert classroom1.valid?, classroom1.errors.full_messages
    assert_not classroom2.valid?, classroom2.errors.full_messages
    assert_match "Name has already been taken", classroom2.errors.full_messages[0]
  end

  test "classroom should be invalid with a name less than 5 characters " do
    classroom = Classroom.new(name: "G-16", floor: 1, wing: "G", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Name is too short (minimum is 5 characters)", classroom.errors.full_messages[0]
  end

  test "classroom should be valid with a name with 5 characters " do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "G", point: @point)

    assert classroom.valid?, classroom.errors.full_messages
  end

  test "classroom should be invalid with a name more than 5 characters " do
    classroom = Classroom.new(name: "GE-1644", floor: 1, wing: "G", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Name is too long (maximum is 5 characters)", classroom.errors.full_messages[0]
  end

  test "classroom should be invalid without proper format" do
    classroom = Classroom.new(name: "12345", floor: 1, wing: "G", point: @point)
    classroom2 = Classroom.new(name: "45-GE", floor: 1, wing: "G", point: @point)
    classroom3 = Classroom.new(name: "GE123", floor: 1, wing: "G", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_not classroom2.valid?, classroom.errors.full_messages
    assert_not classroom3.valid?, classroom.errors.full_messages
    assert_match "Name is invalid", classroom.errors.full_messages[0]
    assert_match "Name is invalid", classroom2.errors.full_messages[0]
    assert_match "Name is invalid", classroom3.errors.full_messages[0]
  end



  # Wing validation

  test "classroom should be invalid with no wing" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Wing can't be blank", classroom.errors.full_messages[0]
  end

  test "classroom should be valid with 1 letter wing" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "G", point: @point)

    assert classroom.valid?, classroom.errors.full_messages
  end

  test "classroom should be invalid with 2 letter wing" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "GG", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Wing is too long (maximum is 1 character)", classroom.errors.full_messages[0]
  end

  test "classroom should be invalid with a number wing" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "2", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Wing is invalid", classroom.errors.full_messages[0]
  end

  # Floors validation

  test "classroom should be valid with no floor" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "G", point: @point)

    assert classroom.valid?, classroom.errors.full_messages
    assert_equal classroom.floor, DEFAULT_FLOOR
  end

  test "classroom should be invalid with letter for floors" do
    classroom = Classroom.new(name: "G-164", floor: "G", wing: "G", point: @point)

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Floor is not a number", classroom.errors.full_messages[0]
  end

  # Point validation

  test "classroom should be valid with a point" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "G", point: @point)

    assert classroom.valid?, classroom.errors.full_messages
  end

  test "classroom should be invalid with no point" do
    classroom = Classroom.new(name: "G-164", floor: 1, wing: "G")

    assert_not classroom.valid?, classroom.errors.full_messages
    assert_match "Point can't be blank", classroom.errors.full_messages[0]
  end

end
