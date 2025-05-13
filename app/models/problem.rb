class Problem < ApplicationRecord
  has_many :solves, dependent: :destroy

  def is_solved_by?(tile)
    tile.in? solution_tiles
  end


  def hand_tiles
    parse_tiles(hand_notation)
  end

  def solution_tiles
    parse_tiles(solution_notation)
  end

  private
  def parse_tiles(input)
    input
      .scan(/(?<numbers>[0-9]+)(?<suit>[mpsz])/)
      .flat_map do |numbers, suit|
      numbers.each_char.map { |number| Tile.new(number: number.to_i, suit: suit) }
    end
  end
end
