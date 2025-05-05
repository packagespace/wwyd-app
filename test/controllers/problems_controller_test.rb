require "test_helper"

class ProblemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @problem = problems(:one)
  end

  test "should get index" do
    get problems_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(users(:one))
    get new_problem_url
    assert_response :success
  end

  test "should not get new when unauthenticated" do
    get new_problem_url
    assert_redirected_to new_session_path
  end

  test "should create problem" do
    sign_in_as(users(:one))
    assert_difference("Problem.count") do
      post problems_url, params: {problem: {explanation: @problem.explanation, hand: @problem.hand, solution: @problem.solution, title: @problem.title}}
    end

    assert_redirected_to problem_url(Problem.last)
  end

  test "should not create problem when unauthenticated" do
    assert_no_difference("Problem.count") do
      post problems_url, params: {problem: {explanation: @problem.explanation, hand: @problem.hand, solution: @problem.solution, title: @problem.title}}
    end

    assert_redirected_to new_session_path
    end

  test "should show problem" do
    get problem_url(@problem)
    assert_response :success
  end

  test "should show problem with solve for authenticated user" do
    user = users(:one)
    sign_in_as(user)

    solve = solves(:one)

    get problem_url(@problem)
    assert_response :success

    assert_select "[data-testid='solve-tile']", solve.tile
  end

  test "should show problem with solve for unauthenticated user" do
    # Create a solve and store it in session
    post solves_url, params: {solve: {problem_id: @problem.id, tile: "7m"}}
    solve = Solve.last

    get problem_url(@problem)
    assert_response :success

    # Check that the response contains the expected solve information
    assert_select "[data-testid='solve-tile']", solve.tile
  end

  test "should get edit" do
    sign_in_as(users(:one))
    get edit_problem_url(@problem)
    assert_response :success
  end
  
  test "should not get edit when unauthenticated" do
    get edit_problem_url(@problem)
    assert_redirected_to new_session_path
  end

  test "should update problem" do
    sign_in_as users(:one)
    patch problem_url(@problem), params: {problem: {explanation: @problem.explanation, hand: @problem.hand, solution: @problem.solution, title: @problem.title}}
    assert_redirected_to problem_url(@problem)
  end

  test "should not update problem when unauthenticated" do
    patch problem_url(@problem), params: {problem: {explanation: @problem.explanation, hand: @problem.hand, solution: @problem.solution, title: @problem.title}}
    assert_redirected_to new_session_path
  end

  test "should destroy problem" do
    sign_in_as(users(:one))
    assert_difference("Problem.count", -1) do
      delete problem_url(@problem)
    end

    assert_redirected_to problems_url
    end

  test "should not destroy problem when unauthenticated" do
    assert_no_difference("Problem.count") do
      delete problem_url(@problem)
    end

    assert_redirected_to new_session_path
  end
end
