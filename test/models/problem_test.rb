require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "should return hand tiles with suits added" do
    problem = Problem.new(hand: "44m667p123678s666z", solution: "6p")

    hand_tiles = problem.hand_tiles_to_s

    assert_equal "4m4m6p6p7p1s2s3s6s7s8s6z6z6z", hand_tiles
  end

  test "should return solution tiles with 'OR' added" do
    problem = Problem.new(hand: "5677m34p45579s666z", solution: "7m4s")

    solution_tiles = problem.solution_tiles_to_s

    assert_equal "7m or 4s", solution_tiles
  end

  test "should return hand tiles in original order" do
    problem = Problem.new(hand: "2p343s44455z111m22p", solution: "3s")

    hand_tiles = problem.hand_tiles_to_s

    assert_equal "2p3s4s3s4z4z4z5z5z1m1m1m2p2p", hand_tiles
  end

  test "should return hand tiles when given longhand format" do
    problem = Problem.new(hand: "1m2m3m4m5p6p7p8p9s9s1z1z2z2z", solution: "9s")

    hand_tiles = problem.hand_tiles_to_s

    assert_equal "1m2m3m4m5p6p7p8p9s9s1z1z2z2z", hand_tiles
  end
end
