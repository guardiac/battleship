require "minitest/autorun"
require "minitest/pride"
require 'mocha/minitest'
require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/player"
require "./lib/game"

class GameTest < Minitest::Test
  def setup
    @game = Game.new
    @game.stubs(:custom_board_dimension_message).returns(4)
    @game.stubs(:custom_board_dimension_message).returns(4)
    @game.create_boards
    @game.create_ships
    @game.create_players
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  #can't test_it_prints_out_main_menu
  #can't test_get_user_input

  def test_it_can_create_boards
    assert_instance_of Board, @game.board1
    assert_instance_of Board, @game.board2
  end

  def test_it_can_create_ships
    assert_instance_of Ship, @game.ships1[0]
    assert_instance_of Ship, @game.ships1[1]
    assert_instance_of Ship, @game.ships2[0]
    assert_instance_of Ship, @game.ships2[1]
  end

  def test_it_can_create_players
    assert_instance_of Player, @game.players[0]
    assert_instance_of Player, @game.players[1]
  end

  # TODO: I don't think we need to test that it CAN place ships
  # that's a board method and was tested there but we should somethow
  # test that it places ships randonly
  def test_it_can_randomly_place_computer_ships_on_the_board
  end

  def test_it_can_generate_random_valid_coordinates
    coordinates1 = @game.random_coordinates(@game.players[0], @game.ships1[0].length)
    coordinates2 = @game.random_coordinates(@game.players[0], @game.ships1[1].length)

    assert @game.board1.valid_placement?(@game.ships1[0], coordinates1)
    assert @game.board1.valid_placement?(@game.ships1[1], coordinates2)
  end

  # def test_it_prints_a_message_after_computer_ship_placement
  #   expected = "\nI have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long.\n"
  #
  #   assert expected, @game.computer_message
  # end
  #
  # def test_it_prints_prompt_to_enter_coordinates
  #   assert_equal "Enter the squares for the Cruiser (3 spaces):\n>", @game.coordinates_prompt(@game.ships1[0])
  # end
  #
  # #can't test get_human_coordinates method
  #
  # def test_it_prints_REprompt_to_enter_valid_coordinates
  #   assert_equal "Those are invalid coordinates. Please try again:\n>" , @game.coordinates_reprompt
  # end
  #
  # def test_it_can_end_the_game
  #   assert_equal "I won! I'm the AI ruler of the world!", @game.end_game(@game.players[1])
  #   assert_equal "You won! Woot woot!", @game.end_game(@game.players[0])
  # end
end
