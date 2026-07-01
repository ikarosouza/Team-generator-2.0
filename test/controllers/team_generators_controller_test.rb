require "test_helper"

class TeamGeneratorsControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to login" do
    get new_team_generator_url

    assert_redirected_to new_session_url
  end

  test "persists generated teams for the current user only" do
    user = create_test_user(email: "user1@example.com")
    other_user = create_test_user(name: "Other", email: "user2@example.com")

    8.times do |index|
      user.athletes.create!(name: "Jogador #{index + 1}", level: (index % 5) + 1, guest: false)
    end
    other_user.athletes.create!(name: "Externo", level: 5, guest: false)

    sign_in_as(user)
    post team_generator_url, params: { team_generator: { athlete_ids: user.athletes.pluck(:id), team_size: 4 } }

    assert_redirected_to team_generator_url
    assert_equal 1, user.team_generations.count
    assert_equal 0, other_user.team_generations.count

    get team_generator_url
    assert_response :success
    assert_includes response.body, "Times gerados"
  end
end
