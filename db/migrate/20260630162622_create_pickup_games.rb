class CreatePickupGames < ActiveRecord::Migration[8.1]
  def change
    create_table :pickup_games do |t|
      t.datetime :start_at
      t.integer :duration

      t.timestamps
    end
  end
end
