# frozen_string_literal: true

require_relative './player'

# Clase TicTacToe, recibe los los parametros Player1 y Player2 para asignar el nombre del jugador.
class TicTacToe
  def initialize(player1, player2)
    @name1 = player1
    @name2 = player2
    @board = Array.new(3) { Array.new(3, ' ') }
    @players = [Player.new(@name1, 'X'), Player.new(@name2, 'O')]
    @current_player = @players.first
  end

  def display_board
    puts '  0 1 2'
    @board.each_with_index do |row, i|
      print "#{i} "
      row.each { |cell| print "#{cell} " }
      puts
    end
  end

  def switch_player
    @current_player = @players.cycle.find { |player| player != @current_player }
  end

  def valid_move?(row, col)
    @board[row][col] == ' '
  end

  def make_move(row, col)
    if valid_move?(row, col)
      @board[row][col] = @current_player.symbol
      if check_winner.nil? # Verificar si el movimiento resulta en un ganador antes de cambiar de jugador
        switch_player
      end
    else
      puts 'Movimiento inválido. Inténtalo de nuevo.'
    end
  end

  def check_winner
    return @current_player if check_lines(@board) || check_lines(@board.transpose)
    return @current_player if check_diagonal([@board[0][0], @board[1][1], @board[2][2]])
    return @current_player if check_diagonal([@board[0][2], @board[1][1], @board[2][0]])

    nil
  end

  def check_lines(lines)
    lines.any? { |line| line.uniq.length == 1 && line[0] != ' ' }
  end

  def check_diagonal(diagonal)
    diagonal.uniq.length == 1 && diagonal[0] != ' '
  end

  def board_full?
    @board.flatten.none?(' ')
  end

  def game_over?
    check_winner || board_full?
  end

  def playing_game
    until game_over?
      display_board
      puts "\nEste es el turno de #{@current_player.name}. Ingresa la fila y la columna (ej. 0 1)."
      move = gets.chomp.split.map(&:to_i)
      make_move(*move)
      puts
    end

    display_board

    announcement
  end

  def announcement
    if check_winner
      puts "Jugador #{@current_player.name} ha ganado"
    else
      puts '¡El juego ha resultado en empate!'
    end
  end
end

game = TicTacToe.new('Alan', 'Tirzo')
game.playing_game
