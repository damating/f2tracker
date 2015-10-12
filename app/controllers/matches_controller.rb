class MatchesController < ApplicationController

  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.save
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    Match.find(params[:id]).destroy
    redirect_to '/players'
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])
    if @match.update_attributes(match_params)
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
