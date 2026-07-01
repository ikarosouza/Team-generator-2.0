class CreatePickupGameAthletes < ActiveRecord::Migration[8.1]
  def change
    create_table :pickup_game_athletes do |t|
      t.references :pickup_game, null: false, foreign_key: true
      t.references :athlete, null: false, foreign_key: true

      t.timestamps
    end
  end
end
