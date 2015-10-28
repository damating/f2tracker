class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.integer :points_limit
      t.string :icon
      t.timestamps null: false
    end
  end
end
