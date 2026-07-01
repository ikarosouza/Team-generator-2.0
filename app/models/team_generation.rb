class TeamGeneration < ApplicationRecord
  belongs_to :user, inverse_of: :team_generations

  validates :team_size, presence: true,
                        numericality: { only_integer: true, greater_than: 0 }

  validate :payloads_are_arrays

  private

  def payloads_are_arrays
    errors.add(:selected_athlete_ids, "precisa ser uma lista") unless selected_athlete_ids.is_a?(Array)
    errors.add(:teams_payload, "precisa ser uma lista") unless teams_payload.is_a?(Array)
    errors.add(:bench_payload, "precisa ser uma lista") unless bench_payload.is_a?(Array)
  end
end
