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
    @current_player = @players.find { |player| player != @current_player }
  end

  def valid_move?(row, col)
    @board[row][col] == ' '
  end

  def make_move(row, col)
    if valid_move?(row, col)
      @board[row][col] = @current_player.symbol
      switch_player
    else
      puts 'Movimiento inválido. Inténtalo de nuevo.'
    end
  end

  def check_winner
    # Revisar filas y columnas
    @board.each do |line|
      return @current_player if line.uniq.length == 1 && line[0] != ' '
    end

    @board.transpose.each do |line|
      return @current_player if line.uniq.length == 1 && line[0] != ' '
    end

    # Revisar diagonales
    return @current_player if [@board[0][0], @board[1][1], @board[2][2]].uniq.length == 1 && @board[0][0] != ' '
    return @current_player if [@board[0][2], @board[1][1], @board[2][0]].uniq.length == 1 && @board[0][2] != ' '

    nil
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
      puts "Este es el turno de #{@current_player.name}. Ingresa la fila y la columna (ej. 0 1)."
      move = gets.chomp.split.map(&:to_i)
      make_move(*move)
    end

    display_board

    announcement
  end

  def announcement
    if check_winner
      puts "Jugador #{check_winner.name} ha ganado"
    else
      puts '¡El juego ha resultado en empate!'
    end
  end
end

game = TicTacToe.new('Alan', 'Tirzo')
game.playing_game
