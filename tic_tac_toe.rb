class Game
  attr_accessor :turn_count, :player1, :player2, :the_board

  @@win_condition = [[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6],[3,4,5],[0,1,2],[6,7,8]]

  def initialize 
    @turn_count = 0
    @player1 = nil
    @player2= nil
    @the_board = nil
  end
  
  def start
    playerNames
    @the_board = Board.new
    turns(player1)
  end

  class Player
    attr_reader :name, :mark

    def initialize(name, mark)
     @name = name
     @mark = mark
    end
  end

  class Board
    attr_accessor :board
    
    def initialize
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
  end

  def display_board
    p @the_board.board[0].to_s + '|' + @the_board.board[1].to_s + '|' + @the_board.board[2].to_s
    p @the_board.board[3].to_s + '|' + @the_board.board[4].to_s + '|' + @the_board.board[5].to_s
    p @the_board.board[6].to_s + '|' + @the_board.board[7].to_s + '|' + @the_board.board[8].to_s
  end

  def playerNames
    puts 'Please enter name of the first player'
    @player1 = Player.new(gets.chomp, mark: 'X')
    p player1.name

    puts 'Please enter name of the second player'
    @player2 = Player.new(gets.chomp, mark: 'O')
    p player2.name
  end

  def turns (turn_of_player)  
    while turn_count<=8 do
      display_board
      p turn_of_player.name + ", " +"It is your turn; select an empty place to mark"
      player_input (turn_of_player)
      if game_finished? 
        winner_message (turn_of_player)
        break
      end
      @turn_count += 1
      turn_of_player = switch_player(turn_of_player)
    end
    if turn_count==9
      no_winner_message 
    end
  end

  def play(player, location)
    the_board.board[location] = player.mark[:mark]
  end

  def player_input(player)
    user_select = (gets.chomp).to_i
    if the_board.board.include? user_select
      play(player, user_select-1)
    else 
      turns(player)
    end 
  end

  def switch_player(player)
    if player == player1
      player2
    elsif player == player2
      player1
    end
  end

  def game_finished?
    control_arr = []
    @@win_condition.each do |index_arr|
      control_arr = [the_board.board[index_arr[0]],the_board.board[index_arr[1]],the_board.board[index_arr[2]]]
      if control_arr.uniq.size == 1
        return true
      end
    end    
    return false
  end

  def winner_message(player)
    p player.name + ", won!!"
  end
  
  def no_winner_message
    p "No winner :|"
  end
end




new_game = Game.new
new_game.start
