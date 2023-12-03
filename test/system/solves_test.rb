require "application_system_test_case"

class SolvesTest < ApplicationSystemTestCase
  setup do
    @solve = solves(:one)
  end

  test "visiting the index" do
    visit solves_url
    assert_selector "h1", text: "Solves"
  end

  test "should create solve" do
    visit solves_url
    click_on "New solve"

    fill_in "Problem", with: @solve.problem_id
    fill_in "Tile", with: @solve.tile
    fill_in "User", with: @solve.user_id
    click_on "Create Solve"

    assert_text "Solve was successfully created"
    click_on "Back"
  end

  test "should update Solve" do
    visit solve_url(@solve)
    click_on "Edit this solve", match: :first

    fill_in "Problem", with: @solve.problem_id
    fill_in "Tile", with: @solve.tile
    fill_in "User", with: @solve.user_id
    click_on "Update Solve"

    assert_text "Solve was successfully updated"
    click_on "Back"
  end

  test "should destroy Solve" do
    visit solve_url(@solve)
    click_on "Destroy this solve", match: :first

    assert_text "Solve was successfully destroyed"
  end
end
