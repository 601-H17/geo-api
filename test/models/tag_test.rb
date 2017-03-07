require 'test_helper'

class TagTest < ActiveSupport::TestCase

  setup do
    @point = points(:one)
    @classroom = Classroom.new(name: "G-164", description: "A description", wing: "G", floor: 1, point: @point)
  end

  test "tag should have a name" do
    tag = Tag.new(name: "A tag")

    assert tag.valid?, tag.errors.full_messages
  end

  test "tag should be invalid with name not present" do
    tag = Tag.new(name: "")

    assert_not tag.valid?, tag.errors.full_messages
    assert_match "Name can't be blank", tag.errors.full_messages[0]
  end

  test "tag should be invalid with name not unique (case sensitive)" do
    tag1 = tags(:one)

    tag2 = Tag.new(name: tag1.name)

    assert tag1.valid?, tag1.errors.full_messages
    assert_not tag2.valid?, tag2.errors.full_messages
    assert_match "Name has already been taken", tag2.errors.full_messages[0]
  end

  test "tag should be invalid with name with less than 3 characters" do
    tag = Tag.new(name: "aa")

    assert_not tag.valid?, tag.errors.full_messages
    assert_match "Name is too short (minimum is 3 characters)", tag.errors.full_messages[0]
  end

  test "tag should be invalid with name with more than 20 characters" do
    tag = Tag.new(name: "a" * 21)

    assert_not tag.valid?, tag.errors.full_messages
    assert_match "Name is too long (maximum is 20 characters)", tag.errors.full_messages[0]
  end

  test "tag should have a classroom" do
    tag = Tag.new(name: "A tag")
    tag.classrooms << @classroom

    assert tag.valid?, tag.errors.full_messages
    assert 1, tag.classrooms.count
    assert @classroom.name, tag.classrooms[0].name
  end

end
