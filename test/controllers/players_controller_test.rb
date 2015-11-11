require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should create player" do
    get :new
    assert_difference 'Player.count', 1 do
      post :create, player: {first_name: "Bob", last_name: "Bob", email: "bob@email.com",
                                password: "Bob123", password_confirmation: "Bob123" }, commit: "Create player"
    end

    assert_redirected_to players_path
  end
end
