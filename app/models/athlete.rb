class Athlete < ApplicationRecord
  belongs_to :user, inverse_of: :athletes
  has_many :pickup_game_athletes, dependent: :destroy, inverse_of: :athlete
  has_many :pickup_games, through: :pickup_game_athletes

  attribute :guest, :boolean, default: false

  scope :regular, -> { where(guest: false) }
  scope :guests, -> { where(guest: true) }

  validates :name, presence: true
  validates :level, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
