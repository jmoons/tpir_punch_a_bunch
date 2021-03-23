# Value Frequency
# $10,000 2
# $5,000  3
# $1,000  5
# $500  10
# $250  10
# $100  10
# $50 10

class PunchABunch

  PRIZES = [
    [10000] * 2,
    [5000]  * 3,
    [1000]  * 5,
    [500]   * 10,
    [250]   * 10,
    [100]   * 10,
    [50]   * 10
  ]

  NUMBER_OF_ROWS    = 5
  NUMBER_OF_COLUMNS = 10
  NUMBER_OF_PUNCHES = 4
  CONTINUE_STRING   = "C"
  KEEP_STRING       = "K"

  def initialize
    @prize_board    = build_game_prizes
    @users_punches  = get_user_punches

    determine_won_amount
  end

  private

  def determine_won_amount
    current_amount = @users_punches.shift
    puts "Current Amount: #{current_amount}"

    if @users_punches.length == 0
      end_game(current_amount)
    else
      user_input = get_user_continue
      determine_won_amount if user_input == CONTINUE_STRING
      end_game(current_amount) if user_input == KEEP_STRING
    end
  end

  def end_game(current_amount)
    puts "You Won: #{current_amount}"
    puts "Reamining Amounts: #{@users_punches.inspect}"
  end

  def get_user_punches
    #return array of four punch values
    user_punches = []
    NUMBER_OF_PUNCHES.times do | punch_number |
      user_row    = get_user_row
      user_column = get_user_column

      user_punches << @prize_board[ user_row - 1 ][ user_column - 1]

    end

    user_punches
  end

  def get_user_continue
    puts "Keep current amount or Continue to Play? (#{KEEP_STRING} or #{CONTINUE_STRING}): "
    user_input = gets
    user_input = user_input.chomp.upcase

    get_user_continue unless ( user_input == KEEP_STRING || user_input == CONTINUE_STRING)

    user_input
  end

  def get_user_row
    puts "Punch which Row, 1 - #{NUMBER_OF_ROWS}?: "
    user_input = gets
    user_input = user_input.to_i

    get_user_row unless (1..NUMBER_OF_ROWS).include?(user_input)

    user_input
  end

  def get_user_column
    puts "Punch which column, 1 - #{NUMBER_OF_COLUMNS}?: "
    user_input = gets
    user_input = user_input.to_i

    get_user_column unless (1..NUMBER_OF_COLUMNS).include?(user_input)

    user_input
  end

  def build_game_prizes

    game_prizes = PRIZES.flatten.shuffle
    prize_board = []
    NUMBER_OF_ROWS.times do 
      prize_board << game_prizes.shift( NUMBER_OF_COLUMNS )
    end

    prize_board
  end

end

PunchABunch.new