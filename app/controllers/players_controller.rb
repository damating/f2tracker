class PlayersController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_action :require_player, only: [:edit, :show]

  def index
    @players = Player.search(params[:search])
  end

  def signup
    @player = Player.new
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if params[:commit] == 'Sign up'
      if @player.save
        redirect_to root_path
      else
        redirect_to signup_path
      end
    elsif params[:commit] == 'Create player'
      if @player.save
        redirect_to :action => :index
      else
        redirect_to new_player_path
      end
    end
  end

  def destroy
    if current_player == Player.find(params[:id])
      session[:player_id] = nil
      Player.find(params[:id]).destroy
      redirect_to root_path
    else
      Player.find(params[:id]).destroy
      redirect_to players_path
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      redirect_to players_path
    else
      render edit_player_path
    end
  end

  def show
    @player = Player.find(params[:id])
    if @player.nil?
      redirect_to :action => :index and return
    end
  end

  def statistics
    @players = Player.order(sort_column + ' ' + sort_direction)
  end

  #check that the sort parameter matches one of the fields in Player model
  private
  def sort_column
    Player.column_names.include?(params[:sort]) ? params[:sort] : "wins"
  end

  #check that the passed parameter matches one of two values
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :role, :wins, :losts, :points, :goals, :badge_id)
  end

end

