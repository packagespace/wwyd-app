class Problem < ApplicationRecord
  has_many :solves, dependent: :destroy

  def is_solved_by?(answer)
    solution.gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        return true if answer == "#{number}#{suit}"
      end
    end
    false
  end


  def hand_tiles
    parse_tiles(hand)
  end

  def solution_tiles
    parse_tiles(solution)
  end

  private
  def parse_tiles(input)
    input
      .scan(/(?<numbers>[1-9]+)(?<suit>[mpsz])/)
      .flat_map do |numbers, suit|
      numbers.each_char.map { |number| Tile.new(number: number.to_i, suit: suit) }
    end
  end
end
