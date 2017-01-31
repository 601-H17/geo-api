require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  test "admin should have username, email and password" do
    admin = Admin.new(username: "an admin", email: "admin@admin.com", password: "password")
    assert admin.valid?, admin.errors.full_messages
  end

  # username validations

  test "admin should be invalid with username not present" do
    admin = Admin.new(username: "", email: "admin@admin.com", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Username can't be blank", admin.errors.full_messages[0]
  end

  test "admin should be invalid with username not unique (case sensitive)" do
    already_registered_admin = Admin.new(username: "anAdmin", email: "admin@admin.com", password: "password")
    already_registered_admin.save

    first_admin = Admin.new(username: "anAdmin", email: "first.admin@admin.com", password: "password")
    second_admin = Admin.new(username: "anadmin", email: "second.admin@admin.com", password: "password")

    assert_not first_admin.valid?, first_admin.errors.full_messages
    assert_match "Username has already been taken", first_admin.errors.full_messages[0]
    assert_not second_admin.valid?, second_admin.errors.full_messages
    assert_match "Username has already been taken", second_admin.errors.full_messages[0]
  end

  test "admin should be invalid with username too short (less than 3)" do
    admin = Admin.new(username: "aa", email: "admin@admin.com", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Username is too short (minimum is 3 characters)", admin.errors.full_messages[0]
  end

  test "admin should be invalid with username too long (more than 30)" do
    admin = Admin.new(username: "a" * 31, email: "admin@admin.com", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Username is too long (maximum is 30 characters)", admin.errors.full_messages[0]
  end

  # email validations

  test "admin should be invalid with email not present" do
    admin = Admin.new(username: "an admin", email: "", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Email can't be blank", admin.errors.full_messages[0]
  end

  test "admin should be invalid with email not unique (case sensitive)" do
    already_registered_admin = Admin.new(username: "anAdmin", email: "admin@admin.com", password: "password")
    already_registered_admin.save

    admin = Admin.new(username: "firstAdmin", email: "admin@admin.com", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Email has already been taken", admin.errors.full_messages[0]
  end

  test "admin should be invalid with email too long (more than 200)" do
    admin = Admin.new(username: "Admin", email: "#{"a" * 191}@admin.com", password: "password")

    assert_not admin.valid?, admin.errors.full_messages
    assert_match "Email is too long (maximum is 200 characters)", admin.errors.full_messages[0]
  end

  # password validations

  test "admin should be invalid with password not present" do
    admin = Admin.new(username: "an admin", email: "admin@admin.com", password: "")
    assert_not admin.valid?, admin.errors.full_messages
  end

end
