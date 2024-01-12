# frozen_string_literal: true

# Módulo
module BoardHelpers
  private

  def lines_winner(lines)
    lines.each do |line|
      return @current_player if line.uniq.length == 1 && line[0] != ' '
    end
    nil
  end

  def diagonals
    [
      [board_value(0, 0), board_value(1, 1), board_value(2, 2)],
      [board_value(0, 2), board_value(1, 1), board_value(2, 0)]
    ]
  end

  def display_board
    puts '  0 1 2'
    @board.each_with_index do |row, i|
      print_row_number(i)
      print_row_cells(row)
      puts
    end
  end

  def board_full?
    @board.flatten.none?(' ')
  end

  def print_row_number(row_number)
    print "#{row_number} "
  end

  def print_row_cells(row)
    row.each { |cell| print "#{cell} " }
  end

  def board_value(row, col)
    @board[row][col]
  end
end
