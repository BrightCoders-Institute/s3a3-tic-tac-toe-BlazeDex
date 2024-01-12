# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../src/player'

# :reek:InstanceVariableAssumption
# Realizando pruebas correspondientes a player
class TestPlayer < Minitest::Test
  def setup
    @player = Player.new('John', 'X')
  end

  def test_player_has_name
    assert_equal 'John', @player.name
  end

  def test_player_has_symbol
    assert_equal 'X', @player.symbol
  end

  def test_player_attributes_are_readonly
    assert_raises(NoMethodError) { @player.name = 'Jane' }
    assert_raises(NoMethodError) { @player.symbol = 'O' }
  end
end
