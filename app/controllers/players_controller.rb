class PlayersController < ApplicationController

  before_action :require_player, only: [:index]

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
          redirect_to '/signup'
        end
    elsif params[:commit] == 'Add player'
         if @player.save
          redirect_to '/players'
        else
          redirect_to '/players'
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

  private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :email, :password)
  end

end
