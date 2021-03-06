require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/messages'
require './lib/ship'

class MessagesTest < Minitest::Test
  def test_main_menu_message
    expected = "\n🚢 Welcome to BATTLESHIP ⚓ 🏴‍☠️\nEnter p to play. Enter q to quit."

    assert_equal expected, Messages.main_menu
  end

  def test_play_or_quit
    expected = "Enter p to play. Enter q to quit."

    assert_equal expected, Messages.play_or_quit
  end

  def test_thanks_for_playing
    expected = "Thanks for Playing!"

    assert_equal expected, Messages.thanks
  end


  def test_coordinates_prompt
    mock_ship1 = {}
    mock_ship2 = {}
    mock_ship1.stubs(:type).returns("Cruiser")
    mock_ship1.stubs(:length).returns(3)
    mock_ship2.stubs(:type).returns("Sub")
    mock_ship2.stubs(:length).returns(2)

    expected1 = "Enter the squares for the Cruiser (3 spaces):\n>"
    expected2 = "Enter the squares for the Sub (2 spaces):\n>"

    assert_equal expected1, Messages.coordinates_prompt(mock_ship1)
    assert_equal expected2, Messages.coordinates_prompt(mock_ship2)
  end

  def test_coordinates_reprompt
    expected = "Those are invalid coordinates. Please try again:\n>"

    assert_equal expected, Messages.coordinates_reprompt
  end

  def test_custom_board_dimension_prompt
    expected = "\nWould you like to set a custom board size? (y/n)\n"

    assert_equal expected, Messages.custom_board_dimension_prompt
  end

  def test_set_dimension_msg
    expected1 = "Setting the board width to be 5"
    expected2 = "Setting the board height to be 7"

    assert_equal(expected1, Messages.set_dimension_msg("width", 5))
    assert_equal(expected2, Messages.set_dimension_msg("height", 7))
  end

  def test_enter_pos_num
    expected = "\nPlease enter a positive whole number from 4-9 for the board HEIGHT"

    assert_equal expected, Messages.enter_pos_num("height")
  end

  def test_use_default_dimension
    assert_equal "Continuing with the default width of 4.", Messages.use_default_dimension("width")
    assert_equal "Continuing with the default height of 4.", Messages.use_default_dimension("height")
  end

  def test_invalid
    assert_equal "Invalid input.", Messages.invalid
  end

  def test_repeat_hit_warning
    mock_cell = mock('cell 1')
    mock_cell.stubs(:coordinate).returns("B2")

    assert_equal "*** WARNING FIRED ON B2 PREVIOUSLY ***", Messages.repeat_hit_warning(mock_cell)
  end

  def test_end_game
    mock_ai_winner = mock("ai player")
    mock_human_winner = mock("human player")
    mock_ai_winner.stubs(:is_computer).returns(true)
    mock_human_winner.stubs(:is_computer).returns(false)
    expected_ai_win = "I won! I'm the AI ruler of the world!"
    expected_human_win = "You won! Woot woot!"

    assert_equal expected_ai_win, Messages.end_game(mock_ai_winner)
    assert_equal expected_human_win, Messages.end_game(mock_human_winner)
  end

  def test_layout
    mock_ship1 = mock("ship 1 Cruiser")
    mock_ship2 = mock("ship 2 Sub")
    mock_ship3 = mock("ship 3 Battleship")
    mock_ship1.stubs(:type).returns("Cruiser")
    mock_ship1.stubs(:length).returns(3)
    mock_ship2.stubs(:type).returns("Sub")
    mock_ship2.stubs(:length).returns(2)
    mock_ship3.stubs(:type).returns("Battleship")
    mock_ship3.stubs(:length).returns(4)
    mock_ships1 = [mock_ship1, mock_ship2, mock_ship3]
    mock_ships2 = [mock_ship1, mock_ship2]
    expected1 = "\nI have laid out my ships on the grid.\nYou now need to lay out your 3 ships.\nThe Cruiser is 3 units long, the Sub is 2 units long, and the Battleship is 4 units long.\n"
    expected2 = "\nI have laid out my ships on the grid.\nYou now need to lay out your 3 ships.\nThe Cruiser is 3 units long, and the Sub is 2 units long.\n"

    assert_equal expected1, Messages.layout(mock_ships1)
    assert_equal expected2, Messages.layout(mock_ships2)
  end

  def test_conjunction_helper_first_index
    mock_ships = [{}, {}, {}]

    assert_equal "The", Messages.conjunction_helper(mock_ships, 0)
  end

  def test_type_and_length
    mock_ship1 = mock('ship 1')
    mock_ship2 = mock('ship 2')
    mock_ship1.stubs(:type).returns("Cruiser")
    mock_ship1.stubs(:length).returns(3)
    mock_ship2.stubs(:type).returns("Sub")
    mock_ship2.stubs(:length).returns(2)

    assert_equal " Cruiser is 3 units long", Messages.type_and_length(mock_ship1)
    assert_equal " Sub is 2 units long", Messages.type_and_length(mock_ship2)
  end

  def test_check_end_message
    mock_ships = [{}, {}, {}]
    not_last_index = 1
    last_index = 2

    assert_equal "", Messages.check_end_message(mock_ships, not_last_index)
    assert_equal ".\n", Messages.check_end_message(mock_ships, last_index)
  end

  def test_conjunction_helper_middle_index
    mock_ships = [{}, {}, {}]

    assert_equal ", the", Messages.conjunction_helper(mock_ships, 1)
  end

  def test_conjunction_helper_last_index
    mock_ships = [{}, {}, {}]

    assert_equal ", and the", Messages.conjunction_helper(mock_ships, 2)
  end

  def test_enter_coord_msg
    assert_equal "Enter the coordinate for your shot:", Messages.enter_coord_msg
  end

  def test_not_valid_coord_msg
    assert_equal "Please enter a valid coordinate:", Messages.not_valid_coord_msg
  end
end
