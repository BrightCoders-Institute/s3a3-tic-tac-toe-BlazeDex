# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/tic_tac_toe'

# Inicializando la prueba
class TicTacToeTest < Minitest::Test
  def setup
    @tic_tac_toe = TicTacToe.new('Player1', 'Player2')
  end

  def test_initialization
    assert_equal 'Player1', @tic_tac_toe.current_player.name
    assert_equal 'X', @tic_tac_toe.current_player.symbol
    assert_equal ' ', @tic_tac_toe.instance_variable_get(:@board)[0][0]
  end

  def test_switch_player
    @tic_tac_toe.send(:switch_player) # Usar send para llamar a un método privado
    assert_equal 'Player2', @tic_tac_toe.current_player.name
    assert_equal 'O', @tic_tac_toe.current_player.symbol
  end
end
