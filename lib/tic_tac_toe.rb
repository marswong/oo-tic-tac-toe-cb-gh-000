class TicTacToe
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def board
    @board
  end

  def board=(board)
    @board = board
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0, 8) && !@position_taken?(index)
  end

  def turn_count
    count = 0

    @board.each do |x|
      if x != " "
        count += 1
      end
    end

    count
  end

  def current_player
    @turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Please enter 1-9:"

    input = gets.strip
    index = @input_to_index(input)

    if @valid_move?(index)
      @move(index, @current_player)
      @display_board
    else
      @turn
    end
  end

  def won?
    if @board.all? { |x| x == " " }
      return false
    elsif WIN_COMBINATIONS.none? { |comb| @include_array?(comb) }
      return false
    else
      WIN_COMBINATIONS.each do |comb|
        if @include_array?(comb)
          return comb
        end
      end
    end
  end

  def full?
    return @board.none? { |x| x == "" || x == " " || x == nil }
  end

  def draw?
    return !@won? && @full? && WIN_COMBINATIONS.none? { |comb| @include_array?(comb) }
  end

  def over?
    return @won? || @draw?
  end

  def winner
    if @won?
      return @board[@won?[0]]
    else
      return nil
    end
  end

  def include_array?(comb)
    return comb.all? { |x| @position_taken?(x) } && @board[comb[0]] == @board[comb[1]] && @board[comb[1]] == @board[comb[2]]
  end

  def play
    until @over?
      @turn
    end

    if @won?
      puts "Congratulations #{@winner}!"
    end

    if @draw?
      puts "Cat's Game!"
    end
  end
end
