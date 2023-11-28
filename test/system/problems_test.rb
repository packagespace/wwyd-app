require "application_system_test_case"

class ProblemsTest < ApplicationSystemTestCase
  setup do
    @problem = problems(:one)
  end

  test "visiting the index" do
    visit problems_url
    assert_selector "h1", text: "Problems"
  end

  test "should create problem" do
    visit problems_url
    click_on "New problem"

    fill_in "Explanation", with: @problem.explanation
    fill_in "Hand", with: @problem.hand
    fill_in "Solution", with: @problem.solution
    fill_in "Title", with: @problem.title
    click_on "Create Problem"

    assert_text "Problem was successfully created"
    click_on "Back"
  end

  test "should update Problem" do
    visit problem_url(@problem)
    click_on "Edit this problem", match: :first

    fill_in "Explanation", with: @problem.explanation
    fill_in "Hand", with: @problem.hand
    fill_in "Solution", with: @problem.solution
    fill_in "Title", with: @problem.title
    click_on "Update Problem"

    assert_text "Problem was successfully updated"
    click_on "Back"
  end

  test "solve a Problem" do
    visit problem_url(@problem)
    click_on "7m", match: :first

    assert_text "Correct answer!"
    assert_text "Solution:"
    assert_text "Explanation:"
  end

  # test "should destroy Problem" do
  #   visit problem_url(@problem)
  #   click_on "Destroy this problem", match: :first
  #
  #   assert_text "Problem was successfully destroyed"
  # end
end
