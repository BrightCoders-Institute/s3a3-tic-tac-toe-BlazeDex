# frozen_string_literal: true

require_relative 'tic_tac_toe'

# Clase
class App
  def self.run
    puts 'Bienvenido al juego del gato.'
    puts 'Ingresa el nombre del jugador 1: '
    name1 = gets.chomp
    puts 'Ingresa el nombre del jugador 2: '
    name2 = gets.chomp

    @name1 = name1
    @name2 = name2

    gaming = TicTacToe.new(@name1, @name2)
    gaming.play
  end
end

App.run
