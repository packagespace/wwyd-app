require "test_helper"

class SolvesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solve = solves(:one)
    @problem = problems(:one)
  end

  test "should get index" do
    get solves_url
    assert_response :success
  end

  test "should get new" do
    get new_solve_url
    assert_response :success
  end

  test "should create solve and redirect to problem" do
    assert_difference("Solve.count") do
      post solves_url, params: { solve: { problem_id: @solve.problem_id, tile: @solve.tile, user_id: @solve.user_id } }
    end

    assert_redirected_to problem_url(@solve.problem_id)
  end

  test "should store solve in session for unauthenticated user" do
    assert_difference("Solve.count") do
      post solves_url, params: { solve: { problem_id: @problem.id, tile: "7m" } }
    end

    assert_redirected_to problem_url(@problem)

    # Verify the solve ID is stored in session
    solve = Solve.last
    assert_includes session[:solve_ids], solve.id
    assert_nil solve.user_id
  end

  test "should associate solve with current user when authenticated" do
    user = users(:two)
    sign_in_as(user)

    assert_difference("Solve.count") do
      post solves_url, params: { solve: { problem_id: @problem.id, tile: "7m" } }
    end

    solve = Solve.last
    assert_not_nil solve.user_id
    assert_equal user.id, solve.user_id
    assert_nil session[:solve_ids]
  end

  # todo add same test for authenticated user
  test "should not allow to create multiple solves" do
    post solves_url, params: { solve: { problem_id: @solve.problem_id, tile: @solve.tile, user_id: @solve.user_id } }
    assert_difference("Solve.count", 0) do
      post solves_url, params: { solve: { problem_id: @solve.problem_id, tile: @solve.tile, user_id: @solve.user_id } }
    end

    assert_response(:conflict)
  end

  test "should show solve" do
    get solve_url(@solve)
    assert_response :success
  end

  test "should get edit" do
    get edit_solve_url(@solve)
    assert_response :success
  end

  test "should update solve" do
    patch solve_url(@solve), params: { solve: { problem_id: @solve.problem_id, tile: @solve.tile, user_id: @solve.user_id } }
    assert_redirected_to solve_url(@solve)
  end

  test "should destroy solve" do
    assert_difference("Solve.count", -1) do
      delete solve_url(@solve)
    end

    assert_redirected_to solves_url
  end
end
