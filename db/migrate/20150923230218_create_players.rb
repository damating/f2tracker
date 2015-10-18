class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :role
      t.integer :wins
      t.integer :losts
      t.integer :points
      t.integer :goals
      t.timestamps null: false
    end
  end
end
