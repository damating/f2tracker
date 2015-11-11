require 'test_helper'

class PlayersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @player = players(:player)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_redirected_to login_path
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: @player.email, password: 'Player123'}
    assert_redirected_to @player
    follow_redirect! #to actually visit the target page
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", player_path(@player)
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", player_path(@player), count: 0
  end

end
