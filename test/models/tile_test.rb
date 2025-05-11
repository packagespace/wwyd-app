require "test_helper"

class TileTest < ActiveSupport::TestCase
  test "should create valid regular number tiles" do
    assert Tile.new(number: 1, suit: "m").valid?
    assert Tile.new(number: 5, suit: "p").valid?
    assert Tile.new(number: 9, suit: "s").valid?
  end

  test "should create valid honor tiles" do
    (1..7).each do |n|
      assert Tile.new(number: n, suit: "z").valid?
    end
  end

  test "should be invalid for invalid number in number suits" do
    tile = Tile.new(number: 0, suit: "m")
    refute tile.valid?
    assert_includes tile.errors[:number], "must be in range 1..9 for suit tiles"
  end

  test "should be invalid for invalid number in honor suit" do
    tile = Tile.new(number: 8, suit: "z")
    refute tile.valid?
    assert_includes tile.errors[:number], "must be in range 0..7 for honor tiles"
  end

  test "should be invalid for invalid suit" do
    tile = Tile.new(number: 1, suit: "x")
    refute tile.valid?
    assert_includes tile.errors[:suit], "is not included in the list"
  end

  test "should compare tiles correctly" do
    tile1 = Tile.new(number: 5, suit: "m")
    tile2 = Tile.new(number: 5, suit: "m")
    tile3 = Tile.new(number: 5, suit: "p")

    assert_equal tile1, tile2
    refute_equal tile1, tile3
  end

  test "should convert to string correctly" do
    tile = Tile.new(number: 5, suit: "m")
    assert_equal "5m", tile.to_s
  end

  test "should require presence of suit" do
    tile = Tile.new(number: 5)
    refute tile.valid?
    assert_includes tile.errors[:suit], "can't be blank"
  end

  test "should require presence of number" do
    tile = Tile.new(suit: "m")
    refute tile.valid?
    assert_includes tile.errors[:number], "can't be blank"
  end
end
