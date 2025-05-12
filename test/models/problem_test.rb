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
end
