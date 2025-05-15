class Problem < ApplicationRecord
  has_many :solves, dependent: :destroy

  validates :title, presence: true
  validates :hand_notation, presence: true
  validates :solution_notation, presence: true
  validate :valid_hand

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

  def valid_hand
    return if hand_notation.blank?
    unless hand_notation.match?(/^(\d+[a-z])+$/)
      errors.add(:hand_notation, "must be in format like '123m456p789s12345z'")
      return
    end
    if hand_tiles.size != 14
      errors.add(:hand_notation, "must contain exactly 14 tiles (got: #{hand_tiles.size})")
      return
    end
    invalid_tiles = hand_tiles.reject(&:valid?)
    if invalid_tiles.any?
      error_messages = invalid_tiles.map { |tile| "#{tile}: #{tile.errors.full_messages.join(', ')}" }
      errors.add(:hand_notation, "contains invalid tiles: #{error_messages.join('; ')}")
    end
  end

  def parse_tiles(input)
    return [] if input.blank?

    input
      .scan(/(?<numbers>\d+)(?<suit>[a-z])/)
      .flat_map do |numbers, suit|
        numbers.each_char.map { |number| Tile.new(number: number.to_i, suit: suit) }
      end
  end
end
