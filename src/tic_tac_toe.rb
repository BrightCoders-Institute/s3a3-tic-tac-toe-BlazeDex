# frozen_string_literal: true

require_relative './player'

# Clase TicTacToe
class TicTacToe
  def initialize(player1, player2)
    @name1 = player1
    @name2 = player2
    @board = Array.new(3) { Array.new(3, ' ') }
    @players = [Player.new(@name1, 'X'), Player.new(@name2, 'O')]
    @current_player = @players.first
  end

  def display_board
    puts ' 0 1 2'
    @board.each_with_index do |row, i|
      print "#{i} "
      row.each { |cell| print "#{cell} " }
      puts
    end
  end
end
