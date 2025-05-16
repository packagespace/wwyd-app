require "test_helper"

class SolveTest < ActiveSupport::TestCase
  def setup
    @problem = problems(:one) # Assume you have this fixture
    @solve = Solve.new(
      problem: @problem,
      tile_notation: "7m"
    )
  end

  test "should be valid with valid attributes" do
    assert @solve.valid?
  end

  ### Association Tests ###

  test "should belong to problem" do
    @solve.problem = nil
    refute @solve.valid?
    assert_includes @solve.errors[:problem], "must exist"
  end

  test "should optionally belong to user" do
    @solve.user = nil
    assert @solve.valid?

    @solve.user = users(:one) # Assume you have this fixture
    assert @solve.valid?
  end

  ### Validation Tests ###

  test "should require tile_notation" do
    @solve.tile_notation = nil
    refute @solve.valid?
    assert_includes @solve.errors[:tile_notation], "can't be blank"
  end

  test "should validate tile_notation format" do
    invalid_formats = {
      "ab" => "no numbers",
      "12" => "no suit",
      "m1" => "wrong order"
    }

    invalid_formats.each do |format, description|
      @solve.errors.clear
      @solve.tile_notation = format
      refute @solve.valid?
      assert_includes @solve.errors[:tile_notation], "must be in format like '1m'"
    end
  end

  ### to_tile Method Tests ###

  test "to_tile should return valid Tile object" do
    @solve.tile_notation = "1m"
    tile = @solve.to_tile

    assert_instance_of Tile, tile
    assert_equal 1, tile.number
    assert_equal "m", tile.suit
  end

  test "should validate tile is valid" do
    @solve.tile_notation = "0w"
    refute @solve.valid?
  end

  test "should validate tile exists in problem hand" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s12345z",
      solution_notation: "123m"
    )
    problem.save!

    solve = Solve.new(
      problem: problem,
      tile_notation: "4m"  # tile not in hand
    )

    refute solve.valid?
    assert_includes solve.errors[:tile_notation], "tile 4m is not in the problem's hand"
  end

  test "should accept tile that exists in problem hand" do
    problem = Problem.new(
      title: "Test Problem",
      hand_notation: "123m456p789s12345z",
      solution_notation: "123m"
    )
    problem.save!

    solve = Solve.new(
      problem: problem,
      tile_notation: "1m"  # tile in hand
    )

    assert solve.valid?
  end

  test "should handle missing problem gracefully" do
    solve = Solve.new(tile_notation: "1m")
    refute solve.valid?
    assert_includes solve.errors[:problem], "must exist"
  end
end
