require 'test_helper'

class ApiKeyTest < ActiveSupport::TestCase

  test "api key should have a name" do
    api_key = ApiKey.new(name: "My api key")
    assert api_key.valid?, api_key.errors.full_messages
  end

  test "api key should be invalid with name not present" do
    api_key = ApiKey.new
    assert_not api_key.valid?, api_key.errors.full_messages
    assert_match "Name can't be blank", api_key.errors.full_messages[0]
  end

  test "api key should be invalid with name not unique (case sensitive)" do
    already_registered_api_key = ApiKey.new(name: "My API key")
    already_registered_api_key.save

    first_api_key = ApiKey.new(name: "My API key")
    second_api_key = ApiKey.new(name: "My api key")

    assert_not first_api_key.valid?, first_api_key.errors.full_messages
    assert_match "Name has already been taken", first_api_key.errors.full_messages[0]
    assert_not second_api_key.valid?, second_api_key.errors.full_messages
    assert_match "Name has already been taken", second_api_key.errors.full_messages[0]
  end

  test "api key should be invalid with name too short (less than 3)" do
    api_key = ApiKey.new(name: "My")

    assert_not api_key.valid?, api_key.errors.full_messages
    assert_match "Name is too short (minimum is 3 characters)", api_key.errors.full_messages[0]
  end

  test "api key should be invalid with name too long (more than 15)" do
    api_key = ApiKey.new(name: "a" * 16)

    assert_not api_key.valid?, api_key.errors.full_messages
    assert_match "Name is too long (maximum is 15 characters)", api_key.errors.full_messages[0]
  end

end
