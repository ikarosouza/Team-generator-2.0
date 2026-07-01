require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validates presence of name email and password" do
    user = User.new

    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
    assert_includes user.errors[:email], "can't be blank"
  end

  test "normalizes email and authenticates password" do
    user = User.create!(name: "Demo", email: "Demo@Example.com", password: "password123", password_confirmation: "password123")

    assert_equal "demo@example.com", user.reload.email
    assert user.authenticate("password123")
    assert_not user.authenticate("wrong")
  end
end
