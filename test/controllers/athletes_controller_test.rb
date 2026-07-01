require "test_helper"

class AthletesControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to login" do
    get athletes_url

    assert_redirected_to new_session_url
  end

  test "shows only the current user's athletes" do
    user = create_test_user(email: "user1@example.com")
    other_user = create_test_user(name: "Other", email: "user2@example.com")
    own_athlete = user.athletes.create!(name: "João", level: 5, guest: false)
    other_user.athletes.create!(name: "Carlos", level: 1, guest: true)

    sign_in_as(user)
    get athletes_url

    assert_response :success
    assert_includes response.body, own_athlete.name
    assert_not_includes response.body, "Carlos"
  end
end
