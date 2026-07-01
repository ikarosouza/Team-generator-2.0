# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.find_or_create_by!(email: "demo@teamgenerator.local") do |record|
  record.name = "Demo"
  record.password = "password123"
  record.password_confirmation = "password123"
end

athletes = [
  { name: "João", level: 5, guest: false },
  { name: "Pedro", level: 4, guest: false },
  { name: "Lucas", level: 3, guest: false },
  { name: "Marcos", level: 2, guest: false },
  { name: "Rafael", level: 1, guest: false },
  { name: "André", level: 4, guest: true },
  { name: "Bruno", level: 3, guest: true },
  { name: "Diego", level: 2, guest: true }
]

athletes.each do |attrs|
  Athlete.find_or_create_by!(name: attrs[:name], user: user) do |athlete|
    athlete.user = user
    athlete.level = attrs[:level]
    athlete.guest = attrs[:guest]
  end
end
