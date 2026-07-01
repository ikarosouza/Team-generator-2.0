class CreateUsersAndTeamGenerations < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true

    create_table :team_generations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :team_size, null: false
      t.jsonb :selected_athlete_ids, null: false, default: []
      t.jsonb :teams_payload, null: false, default: []
      t.jsonb :bench_payload, null: false, default: []

      t.timestamps
    end

    add_index :team_generations, %i[user_id created_at]

    add_reference :athletes, :user, foreign_key: true
    add_reference :pickup_games, :user, foreign_key: true
  end
end
