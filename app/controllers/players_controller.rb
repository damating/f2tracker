class PlayersController < ApplicationController

  helper_method :sort_column, :sort_direction
  before_action :require_player, only: [:edit, :show]

  def index
    @players = Player.all
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
          redirect_to '/'
        else
          redirect_to signup_path
        end
    elsif params[:commit] == 'Create player'
         if @player.save
          redirect_to '/players'
        else
          redirect_to '/new'
        end
    end
  end

  def destroy
    Player.find(params[:id]).destroy
    redirect_to '/players'
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(player_params)
      redirect_to '/players'
    else
      render 'edit'
    end
  end

  def show
    @player = Player.find(params[:id])
    if @player.nil?
      redirect_to :action => "index" and return
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
    params.require(:player).permit(:first_name, :last_name, :email, :password, :avatar, :role, :wins, :losts, :points, :goals, :badge_id)
  end

end
