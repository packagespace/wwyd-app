require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "should return tiles with suits added" do
    # Arrange
    problem = Problem.new(hand: "44m667p123678s 666'z")

    # Act
    tiles = problem.tiles

    # Assert
    assert_equal "4m4m6p6p7p1s2s3s6s7s8s 6z6z6'z", tiles
  end
end
