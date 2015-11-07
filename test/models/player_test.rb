require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def setup
    @player = Player.new(first_name: "Bob", last_name: "Bob", email: "bob@email.com",
                         password: "Bob123", password_confirmation: "Bob123", role: "player" )
  end

  test "should be valid" do
    assert @player.valid?
  end

  test "first name should be present" do
    @player.first_name = ""
    assert_not @player.valid?
  end

  test "last name should be present" do
    @player.last_name = ""
    assert_not @player.valid?
  end

  test "email should be present" do
    @player.email = ""
    assert_not @player.valid?
  end

  test "first name should not be too long" do
    @player.first_name = "a" * 21
    assert_not @player.valid?
  end

  test "last name should not be too long" do
    @player.last_name = "a" * 31
    assert_not @player.valid?
  end

  test "email should not be too long" do
    @player.email = "a" * 246 + "@email.com"
    assert_not @player.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[player@email.com PLAYER@foo.COM A_PLAY-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @player.email = valid_address
      assert @player.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[player@email,com player_at_foo.org player.name@email.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @player.email = invalid_address
      assert_not @player.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_player = @player.dup
    duplicate_player.email = @player.email
    @player.save
    assert_not duplicate_player.valid?
  end

  # test "password can be blank" do
  #   @player.password = @player.password_confirmation = " " * 6
  #   assert @player.valid?
  # end

  test "email should be saved as lower-case" do
    mixed_case_email = "BoB@EmaIL.CoM"
    @player.email = mixed_case_email
    @player.save
    assert_equal mixed_case_email.downcase, @player.reload.email
  end

  test "password should have a minimum length" do
    @player.password = @player.password_confirmation = "a" * 5
    assert_not @player.valid?
  end


end
