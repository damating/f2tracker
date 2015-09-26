class PlayersController < ApplicationController

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private
  def player_params
    params.require(:player).permit(:first_name, :last_name, :email, :password)
  end

end
