class PickupGame < ApplicationRecord
  belongs_to :user, inverse_of: :pickup_games
  has_many :pickup_game_athletes, dependent: :destroy, inverse_of: :pickup_game
  has_many :athletes, through: :pickup_game_athletes

  attribute :duration, :integer, default: 2

  validates :start_at, presence: true
  validates :duration, presence: true,
                       numericality: { only_integer: true, greater_than: 0 }
end
