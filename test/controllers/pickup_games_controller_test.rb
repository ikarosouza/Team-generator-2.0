require "test_helper"

class PickupGamesControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to login" do
    get pickup_games_url

    assert_redirected_to new_session_url
  end

  test "shows only the current user's pickup games" do
    user = create_test_user(email: "user1@example.com")
    other_user = create_test_user(name: "Other", email: "user2@example.com")
    own_game = user.pickup_games.create!(start_at: Time.zone.parse("2026-06-30 18:00"), duration: 2)
    other_user.pickup_games.create!(start_at: Time.zone.parse("2026-06-30 20:00"), duration: 1)

    sign_in_as(user)
    get pickup_games_url

    assert_response :success
    assert_includes response.body, l(own_game.start_at, format: :short)
    assert_not_includes response.body, "20:00"
  end
end
