module ApplicationHelper
  def sortable(column, title=nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  #check if player is logged in or logged out
  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_player.nil?
  end

  #redirect logged out players to the login page
  def require_player
    redirect_to '/login' unless current_player
  end

  def require_admin
    redirect_to '/' unless current_player.admin?
  end
end
