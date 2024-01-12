# frozen_string_literal: true

require_relative './player'
require_relative './board_helpers'

# Clase TicTac
class TicTacToe
  include BoardHelpers

  attr_reader :current_player

  def initialize(first_player, second_player)
    @board = Array.new(3) { Array.new(3, ' ') }
    @players = [Player.new(first_player, 'X'), Player.new(second_player, 'O')]
    @current_player = @players.first
  end

  def play
    until game_over?
      new_board
      move = obt_valid_move
      make_move(*move)
    end
    new_turn
  end

  private

  def new_board
    clear_console
    display_board
    puts "\nEste es el turno de #{current_player.name}. Ingresa la fila y la columna (ej. 0 1)."
  end

  def new_turn
    clear_console
    display_board
    announce_winner
  end

  def obt_valid_move
    loop do
      move = obt_user_input
      return move if valid_move?(move[0], move[1])

      puts 'Movimiento inválido. La casilla ya está ocupada. Ingresa la fila y la columna nuevamente (ej. 0 1).'
    end
  end

  def obt_user_input
    loop do
      input = gets.chomp.split.map { |coord| coord.match?(/^\d+$/) ? coord.to_i : nil }

      return input if valid_input?(input) && valid_range?(input[0]) && valid_range?(input[1])

      puts 'Entrada inválida. Ingresa solo números del 0 al 2 para la fila y la columna (ej. 0 1).'
    end
  end

  def valid_range?(num)
    (0..2).cover?(num)
  end

  def valid_input?(input)
    input.all?(&:itself) && input.length == 2
  end

  def valid_move?(row, col)
    @board[row][col] == ' '
  end

  def make_move(row, col)
    if valid_move?(row, col)
      @board[row][col] = @current_player.symbol
      switch_player if check_winner.nil?
    else
      puts 'Movimiento inválido. Inténtalo de nuevo.'
    end
  end

  def switch_player
    @current_player = @players.cycle.find { |player| player != @current_player }
  end

  def check_winner
    winner = nil

    [@board, @board.transpose, diagonals].each do |lines|
      winner ||= lines_winner(lines)
    end

    winner
  end

  def game_over?
    check_winner || board_full?
  end

  def announce_winner
    if check_winner
      puts "Jugador #{current_player.name} ha ganado"
    else
      puts '¡El juego ha resultado en empate!'
    end
  end

  def clear_console
    system('clear') || system('cls')
  end
end
