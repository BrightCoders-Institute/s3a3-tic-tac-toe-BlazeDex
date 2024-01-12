# frozen_string_literal: true

require 'minitest/autorun'
require 'stringio'

# Requiere el archivo que contiene la definición de la clase App
require_relative '../src/app'

# Inicializando las pruebas
class TestApp < Minitest::Test
  def setup
    # Redirige la entrada estándar para simular la entrada del usuario
    @input_stream = StringIO.new
    @output_stream = StringIO.new
    $stdin = @input_stream
    $stdout = @output_stream
  end

  def teardown
    # Restaura la entrada y salida estándar después de cada prueba
    $stdin = STDIN
    $stdout = STDOUT
  end

  def test_app_run
    # Simula la entrada del usuario para las pruebas
    @input_stream.puts 'John'
    @input_stream.puts 'Jane'

    # Ejecuta el método run de la clase App
    App.run

    # Obtiene la salida capturada
    output = @output_stream.string

    # Verifica que la salida contiene los mensajes esperados
    assert_includes output, 'Bienvenido al juego del gato.'
    assert_includes output, 'Ingresa el nombre del jugador 1: '
    assert_includes output, 'Ingresa el nombre del jugador 2: '
  end
end
