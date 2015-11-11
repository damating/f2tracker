require 'test_helper'

class PlayersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Player.count' do
      post players_path, player: { first_name:  "",
                               last_name: "",
                               email: "player@invalid",
                               password: "inv",
                               password_confirmation: "alid" }, commit: "Sign up"
    end
    assert_redirected_to signup_path
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'Player.count', 1 do
      post players_path, player: { first_name: "Player",
                                   last_name: "Player",
                                   email: "player@valid.com",
                                   password: "Player123",
                                   password_confirmation: "Player123"}, commit: "Sign up"
    end
    assert_redirected_to root_path
  end
end
