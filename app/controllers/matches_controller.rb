class MatchesController < ApplicationController

  before_action :require_admin, only: [:edit]

  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      @player1_wins = players_won_matches(@match.player1_id)
      @player2_wins = players_won_matches(@match.player2_id)

      @player1_losts = players_losts_matches(@match.player1_id)
      @player2_losts = players_losts_matches(@match.player2_id)

      @player1_points = players_points(@player1_wins,@player1_losts)
      @player2_points = players_points(@player2_wins,@player2_losts)

      @player1_goals = players_goals(@match.player1_id)
      @player2_goals = players_goals(@match.player2_id)

      update_player(@match.player1_id, @player1_wins, @player1_losts, @player1_points, @player1_goals)
      update_player(@match.player2_id, @player2_wins, @player2_losts, @player2_points, @player2_goals)

      @player1_medal = players_medal(@match.player1_id)
      @player2_medal = players_medal(@match.player2_id)

      update_player_medal(@match.player1_id, @player1_medal)
      update_player_medal(@match.player2_id, @player2_medal)
      redirect_to matches_path
    else
      render :new
    end
  end

  def destroy
    @match = Match.find(params[:id])
    Match.find(params[:id]).destroy
    @player1_wins = players_won_matches(@match.player1_id)
    @player2_wins = players_won_matches(@match.player2_id)

    @player1_losts = players_losts_matches(@match.player1_id)
    @player2_losts = players_losts_matches(@match.player2_id)

    @player1_points = players_points(@player1_wins,@player1_losts)
    @player2_points = players_points(@player2_wins,@player2_losts)

    @player1_goals = players_goals(@match.player1_id)
    @player2_goals = players_goals(@match.player2_id)

    update_player(@match.player1_id, @player1_wins, @player1_losts, @player1_points, @player1_goals)
    update_player(@match.player2_id, @player2_wins, @player2_losts, @player2_points, @player2_goals)

    @player1_medal = players_medal(@match.player1_id)
    @player2_medal = players_medal(@match.player2_id)

    update_player_medal(@match.player1_id, @player1_medal)
    update_player_medal(@match.player2_id, @player2_medal)

    redirect_to matches_path
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(match_params)
      @player1_wins = players_won_matches(@match.player1_id)
      @player2_wins = players_won_matches(@match.player2_id)

      @player1_losts = players_losts_matches(@match.player1_id)
      @player2_losts = players_losts_matches(@match.player2_id)

      @player1_points = players_points(@player1_wins,@player1_losts)
      @player2_points = players_points(@player2_wins,@player2_losts)

      @player1_goals = players_goals(@match.player1_id)
      @player2_goals = players_goals(@match.player2_id)

      update_player(@match.player1_id, @player1_wins, @player1_losts, @player1_points, @player1_goals)
      update_player(@match.player2_id, @player2_wins, @player2_losts, @player2_points, @player2_goals)

      @player1_medal = players_medal(@match.player1_id)
      @player2_medal = players_medal(@match.player2_id)

      update_player_medal(@match.player1_id, @player1_medal)
      update_player_medal(@match.player2_id, @player2_medal)

      redirect_to matches_path
    else
      render 'edit'
    end
  end

  def match_params
    params.require(:match).permit(:title, :date, :startTime, :player1_id, :player2_id,
 :player1_goals, :player2_goals)
  end
end

def players_won_matches(player_id)
  Match.get_won_matches(player_id).count
end

def players_losts_matches(player_id)
  Match.get_lost_matches(player_id).count
end

def players_points(wins,losts)
  wins * 3 - losts
end

def players_goals(player_id)
  if Match.get_matches_by_person(player_id).count != 0
    Match.goals_number(player_id)/Match.get_matches_by_person(player_id).count
  else
    return 0
  end
end

def update_player(player_id, player_wins, player_losts, player_points, player_goals)
  Player.where(:id => player_id).update_all(wins: player_wins, losts: player_losts, points: player_points, goals: player_goals)
end

def update_player_medal(player_id, player_medal)
  Player.where(:id => player_id).update_all( badge_id: player_medal)
end

def players_medal(player_id)
  @player = Player.find(player_id)
  @badges = Badge.all
  if @player.points > @badges[1].points_limit
    @player.badge_id = @badges[1].id
  elsif @player.points > @badges[2].points_limit
    @player.badge_id = @badges[2].id
  else
    @player.badge_id = @badges[0].id
  end
  @player.badge_id
  return @player.badge_id
end
