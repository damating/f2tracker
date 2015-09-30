class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_player
  
  #check if player is logged in or logged out
  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end 

  #redirect logged out players to the login page
  def require_player
    redirect_to '/login' unless current_player
  end

  def require_admin
    redirect_to '/' unless current_player.admin?
  end
 
end
