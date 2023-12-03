require "test_helper"

class SolvesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @solve = solves(:one)
  end

  test "should get index" do
    get solves_url
    assert_response :success
  end

  test "should get new" do
    get new_solve_url
    assert_response :success
  end

  test "should create solve" do
    assert_difference("Solve.count") do
      post solves_url, params: { solve: { problem_id: @solve.problem_id, tile: @solve.tile, user_id: @solve.user_id } }
    end

    assert_redirected_to solve_url(Solve.last)
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
