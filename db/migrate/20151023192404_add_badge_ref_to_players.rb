class AddBadgeRefToPlayers < ActiveRecord::Migration
  def change
    add_reference :players, :badge, index: true, foreign_key: true
  end
end
