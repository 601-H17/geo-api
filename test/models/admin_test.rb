require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  test "valid admin" do
    admin = Admin.new(username: "an admin", email: "admin@admin.com")
    assert admin.valid?
  end

end
