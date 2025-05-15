class Problem < ApplicationRecord
  has_many :solves, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :hand_notation, presence: true, length: { maximum: 255 }
  validates :solution_notation, presence: true, length: { maximum: 255 }
  validate :valid_hand, :valid_solution

  def solved_by?(tile)
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

    validate_notation_format(:hand_notation)
    return if errors.include?(:hand_notation)

    validate_hand_size
    validate_tiles_validity(:hand_notation, hand_tiles)
  end

  def valid_solution
    return if solution_notation.blank?

    validate_notation_format(:solution_notation)
    return if errors.include?(:solution_notation)

    validate_tiles_validity(:solution_notation, solution_tiles)
    validate_solution_tiles_in_hand
  end

  def validate_notation_format(field)
    unless send(field).match?(/^(\d+[a-z])+$/)
      errors.add(field, "must be in format like '123m456p789s12345z'")
    end
  end

  def validate_hand_size
    return if hand_tiles.size == 14
    errors.add(:hand_notation, "must contain exactly 14 tiles (got: #{hand_tiles.size})")
  end

  def validate_tiles_validity(field, tiles)
    invalid_tiles = tiles.reject(&:valid?)
    return unless invalid_tiles.any?

    error_messages = invalid_tiles.map { |tile| "#{tile}: #{tile.errors.full_messages.join(', ')}" }
    errors.add(field, "contains invalid tiles: #{error_messages.join('; ')}")
  end

  def validate_solution_tiles_in_hand
    return if solution_tiles.all? { |tile| hand_tiles.include?(tile) }
    errors.add(:solution_notation, "contains tiles not in hand: #{solution_tiles.map(&:to_s).join(', ')}")
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
