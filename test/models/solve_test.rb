require "test_helper"

class SolveTest < ActiveSupport::TestCase
  def setup
    @problem = problems(:one) # Assume you have this fixture
    @solve = Solve.new(
      problem: @problem,
      tile_notation: "1m"
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

  test "should accept valid tile notations" do
    valid_formats = %w[1m 9p 5s 7z]

    valid_formats.each do |format|
      @solve.tile_notation = format
      assert @solve.valid?, "#{format} should be valid"
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
end
