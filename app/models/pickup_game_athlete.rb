class PickupGameAthlete < ApplicationRecord
  belongs_to :pickup_game
  belongs_to :athlete

  validates :athlete_id, uniqueness: { scope: :pickup_game_id }
end
