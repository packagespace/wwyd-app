require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "should return hand tiles with suits added" do
    problem = Problem.new(hand_notation: "44m667p123678s666z", solution_notation: "6p")

    hand_tiles = problem.hand_tiles

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

  test "should return solution tiles with 'OR' added" do
    problem = Problem.new(hand_notation: "5677m34p45579s666z", solution_notation: "7m4s")

    solution_tiles = problem.solution_tiles

    expected_tiles = [
      Tile.new(number: 7, suit: "m"),
      Tile.new(number: 4, suit: "s")
    ]

    assert_equal expected_tiles, solution_tiles
  end

  test "should return hand tiles in original order" do
    problem = Problem.new(hand_notation: "2p343s44455z111m22p", solution_notation: "3s")

    hand_tiles = problem.hand_tiles

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
    problem = Problem.new(hand_notation: "1m2m3m4m5p6p7p8p9s9s1z1z2z2z", solution_notation: "9s")

    hand_tiles = problem.hand_tiles

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

  # Format validation tests
  test "should be invalid with malformed hand notation" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "abc123",
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "must be in format like '123m456p789s12345z'"
  end

  test "should be invalid with spaces in hand notation" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m 456p",
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "must be in format like '123m456p789s12345z'"
  end

  # Size validation tests
  test "should be invalid with less than 14 tiles" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s",
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "must contain exactly 14 tiles (got: 9)"
  end

  test "should be invalid with more than 14 tiles" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s123456z",
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "must contain exactly 14 tiles (got: 15)"
  end

  # Tile validation tests
  test "should be invalid with invalid numbered tile" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s0m1234m",  # 0m is invalid
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_match "contains invalid tiles: 0m: ", problem.errors[:hand_notation].first
  end

  test "should be invalid with invalid honor tile" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s9z1234m",  # 9z is invalid
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_match "contains invalid tiles: 9z:", problem.errors[:hand_notation].first
  end

  test "should be invalid with invalid suit" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s12345x",  # x is not a valid suit
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_match "contains invalid tiles: 1x:", problem.errors[:hand_notation].first
  end

  test "should be valid with correct hand notation" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s123z45m",
      solution_notation: "1m"
    )

    assert problem.valid?
  end

  test "should accept multiple invalid tiles and show all errors" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s8z9z123m",  # both 8z and 9z are invalid
      solution_notation: "1m"
    )

    refute problem.valid?
    error_message = problem.errors[:hand_notation].first
    p error_message
    assert_match(/8z/, error_message)
    assert_match(/9z/, error_message)
  end

  test "should handle empty hand notation" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "",
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "can't be blank"
  end

  test "should handle nil hand notation" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: nil,
      solution_notation: "1m"
    )

    refute problem.valid?
    assert_includes problem.errors[:hand_notation], "can't be blank"
  end
end
