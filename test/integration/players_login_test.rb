require 'test_helper'

class PlayersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    get login_path
  end

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "bob@email.com", password: "Bob123" }
    get pla
  end

end
