require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  setup do
    @problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123456789m123p12s",
      solution_notation: "123m"
    )
  end

  test "should be valid with valid attributes" do
    assert @problem.valid?
  end

  test "should require title" do
    @problem.title = nil
    refute @problem.valid?
    assert_includes @problem.errors[:title], "can't be blank"
  end

  test "should limit title length" do
    @problem.title = "a" * 256
    refute @problem.valid?
    assert_includes @problem.errors[:title], "is too long (maximum is 255 characters)"
  end

  ### Hand Notation Validations ###

  test "should require hand_notation" do
    @problem.hand_notation = nil
    refute @problem.valid?
    assert_includes @problem.errors[:hand_notation], "can't be blank"
  end

  test "should limit hand_notation length" do
    @problem.hand_notation = "1m" * 128
    refute @problem.valid?
    assert_includes @problem.errors[:hand_notation], "is too long (maximum is 255 characters)"
  end

  test "should validate hand_notation format" do
    invalid_formats = [
      "abc",             # no numbers
      "123",             # no suit
      "1m 2p",           # spaces
      "mm123",           # suit before number
      "1mx"              # extra characters
    ]

    invalid_formats.each do |format|
      @problem.errors.clear
      @problem.hand_notation = format
      refute @problem.valid?, "#{format} should be invalid"
      assert_includes @problem.errors[:hand_notation], "must be in format like '123m456p789s12345z'"
    end
  end

  test "should validate hand has exactly 14 tiles" do
    invalid_hands = {
      "123m" => 3,           # too few tiles
      "123456789m123456p" => 15  # too many tiles
    }

    invalid_hands.each do |hand, count|
      @problem.errors.clear
      @problem.hand_notation = hand
      refute @problem.valid?, "#{hand} should be invalid"
      assert_includes @problem.errors[:hand_notation], "must contain exactly 14 tiles (got: #{count})"
    end
  end

  test "should validate tiles in hand are valid" do
    @problem.hand_notation = "123456789w123q90z"
    refute @problem.valid?
    assert_match(/contains invalid tiles/, @problem.errors[:hand_notation].first)
  end

  ### Solution Notation Validations ###

  test "should require solution_notation" do
    @problem.solution_notation = nil
    refute @problem.valid?
    assert_includes @problem.errors[:solution_notation], "can't be blank"
  end

  test "should limit solution_notation length" do
    @problem.solution_notation = "1m" * 128
    refute @problem.valid?
    assert_includes @problem.errors[:solution_notation], "is too long (maximum is 255 characters)"
  end

  test "should validate solution_notation format" do
    invalid_formats = [
      "abc",              # no numbers
      "123",             # no suit
      "1m 2p",           # spaces
      "mm123",           # suit before number
      "1mx"              # extra characters
    ]

    invalid_formats.each do |format|
      @problem.solution_notation = format
      refute @problem.valid?, "#{format} should be invalid"
      assert_includes @problem.errors[:solution_notation], "must be in format like '123m456p789s12345z'"
    end
  end

  test "should validate solution tiles exist in hand" do
    @problem.hand_notation = "123456789m123p1s"
    @problem.solution_notation = "456s"  # tiles not in hand
    refute @problem.valid?
    assert_match(/contains tiles not in hand/, @problem.errors[:solution_notation].first)
  end

  test "should validate solution tiles are valid" do
    @problem.solution_notation = "0w123q9z"
    refute @problem.valid?
    assert_match(/contains invalid tiles/, @problem.errors[:solution_notation].first)
  end

  ### Tile Parsing Tests ###

  test "should return hand tiles with suits added" do
    @problem.hand_notation = "44m667p123678s666z"

    hand_tiles = @problem.hand_tiles

    expected_tiles = [
      Tile.new(number: 4, suit: "m"),
      Tile.new(number: 4, suit: "m"),
      Tile.new(number: 6, suit: "p"),
      Tile.new(number: 6, suit: "p"),
      Tile.new(number: 7, suit: "p"),
      Tile.new(number: 1, suit: "s"),
      Tile.new(number: 2, suit: "s"),
      Tile.new(number: 3, suit: "s"),
      Tile.new(number: 6, suit: "s"),
      Tile.new(number: 7, suit: "s"),
      Tile.new(number: 8, suit: "s"),
      Tile.new(number: 6, suit: "z"),
      Tile.new(number: 6, suit: "z"),
      Tile.new(number: 6, suit: "z")
    ]

    assert_equal expected_tiles, hand_tiles
  end

  test "should return solution tiles" do
    @problem.solution_notation = "7m4s"

    solution_tiles = @problem.solution_tiles

    expected_tiles = [
      Tile.new(number: 7, suit: "m"),
      Tile.new(number: 4, suit: "s")
    ]

    assert_equal expected_tiles, solution_tiles
  end

  test "should return hand tiles in original order" do
    @problem.hand_notation = "2p343s44455z111m22p"

    hand_tiles = @problem.hand_tiles

    expected_tiles = [
      Tile.new(number: 2, suit: "p"),
      Tile.new(number: 3, suit: "s"),
      Tile.new(number: 4, suit: "s"),
      Tile.new(number: 3, suit: "s"),
      Tile.new(number: 4, suit: "z"),
      Tile.new(number: 4, suit: "z"),
      Tile.new(number: 4, suit: "z"),
      Tile.new(number: 5, suit: "z"),
      Tile.new(number: 5, suit: "z"),
      Tile.new(number: 1, suit: "m"),
      Tile.new(number: 1, suit: "m"),
      Tile.new(number: 1, suit: "m"),
      Tile.new(number: 2, suit: "p"),
      Tile.new(number: 2, suit: "p")
    ]

    assert_equal expected_tiles, hand_tiles
  end

  test "should return hand tiles when given longhand format" do
    @problem.hand_notation = "1m2m3m4m5p6p7p8p9s9s1z1z2z2z"

    hand_tiles = @problem.hand_tiles

    expected_tiles = [
      Tile.new(number: 1, suit: "m"),
      Tile.new(number: 2, suit: "m"),
      Tile.new(number: 3, suit: "m"),
      Tile.new(number: 4, suit: "m"),
      Tile.new(number: 5, suit: "p"),
      Tile.new(number: 6, suit: "p"),
      Tile.new(number: 7, suit: "p"),
      Tile.new(number: 8, suit: "p"),
      Tile.new(number: 9, suit: "s"),
      Tile.new(number: 9, suit: "s"),
      Tile.new(number: 1, suit: "z"),
      Tile.new(number: 1, suit: "z"),
      Tile.new(number: 2, suit: "z"),
      Tile.new(number: 2, suit: "z")
    ]

    assert_equal expected_tiles, hand_tiles
  end

  ### Solved By Tests ###

  test "solved_by? should return true for tiles in solution" do
    @problem.hand_notation = "123456789m123p1s"
    @problem.solution_notation = "123m"
    tile = @problem.solution_tiles.first
    assert @problem.solved_by?(tile)
  end

  test "solved_by? should return false for tiles not in solution" do
    @problem.hand_notation = "123456789m123p1s"
    @problem.solution_notation = "123m"
    tile = Tile.new(number: 4, suit: "m")
    refute @problem.solved_by?(tile)
  end
end
