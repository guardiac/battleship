class Game
  attr_reader :players,
              :board1,
              :board2,
              :ships1,
              :ships2

  def start
    puts Messages.main_menu
    user_input = get_user_input
    if user_input == "p"
      setup_game
      take_turns
      check_has_lost
    else
      return puts Messages.thanks
    end
    start
  end

  def setup_game
    create_boards
    create_ships
    create_players
    place_computer_ships
    computer_message
    puts render_human_board
    place_human_ships
  end

  def take_turns
    turn = Turn.new(@players[0], @players[1])
    until @players[0].has_lost? || @players[1].has_lost?
      turn.human_shot
      turn.computer_shot
      puts turn.results
      puts turn.display_boards
    end
  end

  def check_has_lost
    if @players[0].has_lost?
      puts Messages.end_game(@players[1])
    else
      puts Messages.end_game(@players[0])
    end
  end

  def get_user_input
    user_input = gets.chomp.downcase
    unless user_input == "q" || user_input == "p"
      puts Messages.play_or_quit
      return get_user_input
    end
    user_input
  end

  def create_boards
    if custom_board_dimension_message
      width = set_dimension("width")
      height = set_dimension("height")
    else
      width = 4
      height = 4
    end
    @board1 = Board.new(height, width)
    @board2 = Board.new(height, width)
  end

  def create_ships
    cruiser1 = Ship.new("Cruiser", 3)
    submarine1 = Ship.new("Submarine", 2)
    @ships1 = [cruiser1, submarine1]

    cruiser2 = Ship.new("Cruiser", 3)
    submarine2 = Ship.new("Submarine", 2)
    @ships2 = [cruiser2, submarine2]
  end

  def create_players
    player1 = Player.new("Ada Lovelace", @ships1, @board1)
    player2 = Player.new("Watson", @ships2, @board2, true)
    @players = [player1, player2]
  end

  def place_computer_ships
    @players.each do |player|
      if player.is_computer
        player.ships.each do |ship|
          coordinates = random_coordinates(player, ship.length)
          until player.board.valid_placement?(ship, coordinates)
            coordinates = random_coordinates(player, ship.length)
          end
          player.board.place(ship, coordinates)
        end
      end
    end
  end

  def random_coordinates(player, length)
    random_arrays = []
    board = player.board
    if [true, false].sample
      board.rows[board.board_letters.sample].each_cons(length) do |row|
        random_arrays << row
      end
    else
      board.columns[board.board_numbers.sample].each_cons(length) do |column|
        random_arrays << column
      end
    end
    random_arrays.sample
  end

  def computer_message
    @players.each do |player|
      if !player.is_computer
        puts Messages.layout player.ships
      end
    end
  end

  def render_human_board
    @players.select do |player|
      player.is_computer == false
    end[0].board.render
  end

  def place_human_ships
    @players.each do |player|
      if !player.is_computer
        player.ships.each do |ship|
          puts Messages.coordinates_prompt(ship)
          coordinates = get_human_coordinates
          until player.board.valid_placement?(ship, coordinates)
            puts Messages.coordinates_reprompt
            coordinates = get_human_coordinates
          end
          player.board.place(ship, coordinates)
        end
      end
    end
  end

  def get_human_coordinates
    gets.chomp.upcase.split(" ")
  end

  def custom_board_dimension_message
    message = Messages.custom_board_dimension_prompt
    user_input = yes_no_prompt_until(message)
    user_input == "y"
  end

  def set_dimension(dimension)
    puts Messages.enter_pos_num(dimension)
    user_input = gets.chomp.downcase.to_i
    until user_input > 3 && user_input < 10
      puts Messages.invalid + " " + Messages.enter_pos_num
      user_input = gets.chomp.downcase.to_i
    end
    puts Messages.set_dimension_msg(dimension, user_input)
    user_input
  end

  def yes_no_prompt_until(message)
    puts message
    user_input = gets.chomp.downcase
    until user_input == "y" || user_input == "n"
      puts Messages.invalid + " " + message
      user_input = gets.chomp.downcase
    end
    user_input
  end
end
