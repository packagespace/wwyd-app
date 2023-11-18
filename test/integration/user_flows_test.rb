require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @problem = problems(:one)
  end

  test "can solve a problem" do
    get problem_url(@problem)
    assert_response :success
    solutions = css_select "#solution"
    assert_empty solutions
  end
end
