class Problem < ApplicationRecord
  has_many :solves, dependent: :destroy
  attribute :hand_tiles
  attribute :solution_tiles
  after_initialize :parse_hand_tiles, :parse_solution_tiles

  def hand_tiles_to_s
    hand_tiles.join
  end

  def is_solved_by?(answer)
    solution.gsub(%r{(?<numbers>[0-9']*)(?<suit>[mpsz])}) do |_|
      numbers, suit = $1, $2
      numbers.split(%r{(?!')}).each do |number|
        return true if answer == "#{number}#{suit}"
      end
    end
    false
  end

  def solution_tiles_to_s
    self.solution_tiles.join(" or ")
  end

  private
  def parse_hand_tiles
    self.hand_tiles = parse_tiles(hand)
    end

  def parse_solution_tiles
    self.solution_tiles = parse_tiles(solution)
  end

  def parse_tiles(input)
    input.scan(/([1-9]+)([mpsz])/).map do |numbers, suit|
      numbers.chars.map do |number|
        Tile.new(number: number.to_i, suit: suit)
      end
    end
  end
end
