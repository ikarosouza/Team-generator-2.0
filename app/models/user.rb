class User < ApplicationRecord
  has_secure_password

  has_many :athletes, dependent: :destroy, inverse_of: :user
  has_many :pickup_games, dependent: :destroy, inverse_of: :user
  has_many :team_generations, dependent: :destroy, inverse_of: :user

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
