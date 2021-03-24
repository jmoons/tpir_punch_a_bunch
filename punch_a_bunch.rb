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

  NUMBER_OF_ROWS      = 5
  NUMBER_OF_COLUMNS   = 10
  NUMBER_OF_PUNCHES   = 4
  CONTINUE_STRING     = "c"
  KEEP_STRING         = "k"
  MATCH_EXPRESSION    = /(\d+),\s*(\d+)/
  MATCH_ROW_OFFSET    = 1
  MATCH_COLUMN_OFFSET = 2

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

    while ( user_punches.length < NUMBER_OF_PUNCHES )
      user_punch_match_data = get_user_punch

      if validate_punch( user_punch_match_data )
        user_punches << @prize_board[ user_punch_match_data[MATCH_ROW_OFFSET].to_i - 1 ][ user_punch_match_data[MATCH_COLUMN_OFFSET].to_i - 1]
      end

    end

    user_punches
  end

  def get_user_continue
    puts "Keep current amount or Continue to Play? (#{KEEP_STRING} or #{CONTINUE_STRING}): "
    user_input = gets
    user_input = user_input.chomp.downcase

    get_user_continue unless ( user_input == KEEP_STRING || user_input == CONTINUE_STRING)

    user_input
  end

  def validate_punch(punch_match_data)
    valid_punch = !(punch_match_data.nil?)

    valid_punch = valid_punch && punch_match_data.captures.length == 2

    valid_punch = valid_punch &&  ( punch_match_data[MATCH_ROW_OFFSET].to_i > 0 &&
                                    punch_match_data[MATCH_ROW_OFFSET].to_i <= NUMBER_OF_ROWS &&
                                    punch_match_data[MATCH_COLUMN_OFFSET].to_i > 0 &&
                                    punch_match_data[MATCH_COLUMN_OFFSET].to_i <= NUMBER_OF_COLUMNS
                                  )

    valid_punch
  end

  def get_user_punch
    puts "Where do you want to punch (Row (1-5), Column (1-10))?: "
    user_input          = gets
    user_input          = user_input.chomp.match( MATCH_EXPRESSION )

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