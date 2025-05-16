class Solve < ApplicationRecord
  belongs_to :problem
  belongs_to :user, optional: true

  validates :tile_notation, presence: true, length: { maximum: 255 }
  validates :problem, presence: true
  validate :valid_tile

  def to_tile
    number, suit = tile_notation.scan(/\A(?<number>\d+)(?<suit>[a-z])\z/)[0]
    Tile.new(number: number.to_i, suit: suit)
  end

  private

  def valid_tile
    return if tile_notation.blank?

    validate_notation_format
    return if errors.include?(:tile_notation)

    tile = to_tile
    unless tile.valid?
      errors.add(:tile_notation, message: tile.errors.full_messages.join(", "))
    end
  end

  def validate_notation_format
    unless tile_notation.match?(/\A\d+[a-z]\z/)
      errors.add(:tile_notation, message: "must be in format like '1m'")
    end
  end
end
