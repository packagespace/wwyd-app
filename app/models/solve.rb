class Solve < ApplicationRecord
  belongs_to :problem
  belongs_to :user, optional: true

  validates :tile_notation, presence: true

  def to_tile
    number, suit = tile_notation.scan(/([0-9])([mpsz])/)[0]
    Tile.new(number: number.to_i, suit: suit)
  end
end
