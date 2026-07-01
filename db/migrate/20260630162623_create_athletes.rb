class CreateAthletes < ActiveRecord::Migration[8.1]
  def change
    create_table :athletes do |t|
      t.string :name
      t.integer :level
      t.boolean :guest

      t.timestamps
    end
  end
end
