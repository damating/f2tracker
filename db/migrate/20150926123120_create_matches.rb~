class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :title
      t.date   :date
      t.time   :startTime
      t.integer :player1_id
      t.integer :player2_id
      t.integer :winner
      t.integer :player1_goals
      t.integer :player2_goals
      t.timestamps null: false
    end
  end
end
