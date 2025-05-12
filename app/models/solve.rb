class Solve < ApplicationRecord
  belongs_to :problem
  belongs_to :user, optional: true

  def to_tile
    number, suit = tile.scan(/([1-9])([mpsz])/)[0]
    Tile.new(number: number.to_i, suit: suit)
  end
end
