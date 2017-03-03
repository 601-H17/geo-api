require 'test_helper'

class TeacherTest < ActiveSupport::TestCase

  FIRST_NAME = "Yannick"
  LAST_NAME = "Mazzière"

  test "teacher should have first and last name with proper format" do
    teacher = Teacher.new(firstname: FIRST_NAME, lastname: LAST_NAME)

    assert teacher.valid?, teacher.errors.full_messages
  end

  test "teacher should be invalid with no first name" do
    teacher = Teacher.new(firstname: "", lastname: LAST_NAME)

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Firstname can't be blank", teacher.errors.full_messages[0]
  end

  test "teacher should be invalid with no last name" do
    teacher = Teacher.new(firstname: FIRST_NAME, lastname: "")

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Lastname can't be blank", teacher.errors.full_messages[0]
  end

  test "teacher should have first name with less than or equal to 100 characters" do
    teacher = Teacher.new(firstname: "a" * 100, lastname: LAST_NAME)

    assert teacher.valid?, teacher.errors.full_messages
  end

  test "teacher should be invalid with first name with more than 100 characters" do
    teacher = Teacher.new(firstname: "a" * 101, lastname: LAST_NAME)

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Firstname is too long (maximum is 100 characters)", teacher.errors.full_messages[0]
  end

  test "teacher should have last name with less than or equal to 100 characters" do
    teacher = Teacher.new(firstname: FIRST_NAME, lastname: "a" * 100)

    assert teacher.valid?, teacher.errors.full_messages
  end

  test "teacher should be invalid with last name with more than 100 characters" do
    teacher = Teacher.new(firstname: FIRST_NAME, lastname: "a" * 101)

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Lastname is too long (maximum is 100 characters)", teacher.errors.full_messages[0]
  end

  test "teacher should be invalid without first name proper format" do
    teacher = Teacher.new(firstname: "12234!@#$%}{][/|", lastname: LAST_NAME)

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Firstname is invalid", teacher.errors.full_messages[0]
  end

  test "teacher should be invalid without last name proper format" do
    teacher = Teacher.new(firstname: FIRST_NAME, lastname: "12234!@#$%}{][/|")

    assert_not teacher.valid?, teacher.errors.full_messages
    assert_match "Lastname is invalid", teacher.errors.full_messages[0]
  end

end
