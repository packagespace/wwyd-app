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

    assert_equal 14, css_select(".tile img").length
    assert_equal 14, css_select("button.tile").length

    post solve_url(@problem),
      params: {selected_tile: "7m"}
    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_not_empty css_select("#solved-message")
    assert_equal "Correct answer!", css_select("#solved-message").inner_text.strip

    assert_not_empty css_select("#solution")
    assert_equal "7m", css_select("#solution img")[0].attr("alt")
    assert_equal "4s", css_select("#solution img")[1].attr("alt")
    assert_equal "or", css_select("#solution").inner_text.strip

    assert_not_empty css_select("#explanation")
    assert_equal "Discarding  makes the hand 2-away, whereas discarding either  or  makes the hand 1-away. You should thus discard  or  to make the hand 1-away. Reverting a 1-away hand to 2-away makes sense only in some exceptional cases where tile acceptance at 1-away becomes unbearably small (i.e., fewer than 2 kinds). With this hand, the hand will be able to accept 2 (3 kinds–12 tiles) when it becomes 1-away.", css_select("#explanation").inner_text.strip
  end
end
