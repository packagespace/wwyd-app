require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @problem = problems(:one)
  end

  test "can solve a problem" do
    get problem_url(@problem)
    assert_response :success

    assert_empty css_select("#solution")
    assert_empty css_select("#explanation")

    assert_equal css_select(".tile img").length, 14
    assert_equal css_select("button.tile").length, 14

    post solve_url(@problem),
         params: { selected_tile: "7m" }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_not_empty css_select("#solution")
    assert_not_empty css_select("#explanation")
  end
end
