class Tile
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :number, :integer
  attribute :suit, :string

  VALID_SUITS = %w[m p s z].freeze
  VALID_NUMBERED_TILE_NUMBERS = (1..9).freeze
  VALID_HONOR_TILE_NUMBERS = 0..7.freeze

  validates :suit,
            presence: true,
            inclusion: { in: VALID_SUITS, message: "must be m, p, s, or z", allow_blank: true }
  validates :number,
            presence: true,
            inclusion: { in: VALID_NUMBERED_TILE_NUMBERS, message: "must be in range 1-9 for numbered tiles", allow_blank: true },
            if: :numbered_tile
  validates :number,
            presence: true,
            inclusion: { in: VALID_HONOR_TILE_NUMBERS, message: "must be in range 0-7 for honor tiles", allow_blank: true },
            if: :honor_tile

  def to_s
    "#{number}#{suit}"
  end

  def ==(other)
    return false unless other.is_a?(Tile)
    number == other.number && suit == other.suit
  end

  private

  def numbered_tile
    suit.in?(%w[m p s])
  end

  def honor_tile
    suit == "z"
  end
end
