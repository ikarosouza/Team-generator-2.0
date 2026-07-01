require "test_helper"

class TeamGenerationTest < ActiveSupport::TestCase
  test "requires array payloads and a positive team size" do
    user = users(:one)
    generation = TeamGeneration.new(user: user, team_size: 0, selected_athlete_ids: nil, teams_payload: nil, bench_payload: nil)

    assert_not generation.valid?
    assert_includes generation.errors[:team_size], "must be greater than 0"
  end

  test "accepts persisted payloads" do
    user = users(:one)
    generation = TeamGeneration.create!(
      user: user,
      team_size: 4,
      selected_athlete_ids: %w[1 2],
      teams_payload: [[{ "name" => "João", "level" => 5 }]],
      bench_payload: []
    )

    assert_equal 4, generation.team_size
    assert_equal [], generation.bench_payload
  end
end
