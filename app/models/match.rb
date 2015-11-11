class Match < ActiveRecord::Base

  belongs_to :player1, class_name: "Player", foreign_key: "player1_id"
  belongs_to :player2, class_name: "Player", foreign_key: "player2_id"

  before_create :set_winner

  validates_numericality_of :player1_goals, :only_integer => true
  validates_numericality_of :player2_goals, :only_integer => true
  validates :player1_goals, inclusion: {in: 0..10}
  validates :player2_goals, inclusion: {in: 0..10}

  protected
  def set_winner
    if self.player1_goals == 10
      self.winner = player1_id
    else
      self.winner = player2_id
    end
  end

  def player1?(player_id)
    self.player1_id == player_id
  end

  def self.get_matches_by_person(player_id)
    where("player1_id = :person_id OR player2_id = :person_id", person_id: player_id)
  end

  def self.get_won_matches(player_id)
    get_matches_by_person(player_id).where("winner = ?", player_id)
  end

  def self.get_lost_matches(player_id)
    get_matches_by_person(player_id).where("winner != ?", player_id)
  end

  def self.goals_number(player_id)
    where("player1_id = ?", player_id).collect { |i| i.player1_goals }.sum + where("player2_id = ?", player_id).collect { |i| i.player2_goals }.sum
  end

  def self.match_result
    "#{player1_goals} : #{player2_goals}"
  end

  def self.get_opponents
    "#{player1_goals} : #{player2_goals}"
  end

end
