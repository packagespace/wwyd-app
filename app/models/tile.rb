class Tile
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :number, :integer
  attribute :suit, :string

  VALID_SUITS = %w[m p s z].freeze
  VALID_SUIT_TILE_NUMBERS = 1..9.freeze
  VALID_HONOR_TILE_NUMBERS = 0..7.freeze

  validates :suit,
            presence: true,
            inclusion: { in: VALID_SUITS, allow_blank: true }
  validates :number,
            presence: true,
            inclusion: { in: VALID_SUIT_TILE_NUMBERS, message: "must be in range 1..9 for suit tiles", allow_blank: true },
            if: :suit_tile
  validates :number,
            presence: true,
            inclusion: { in: VALID_HONOR_TILE_NUMBERS, message: "must be in range 0..7 for honor tiles", allow_blank: true },
            if: :honor_tile

  def to_s
    "#{number}#{suit}"
  end

  def ==(other)
    number == other.number && suit == other.suit
  end

  private

  def suit_tile
    suit.in?(%w[m p s])
    end

  def honor_tile
    suit == "z"
  end
end
