require "test_helper"

class RegistrationFlowTest < ActionDispatch::IntegrationTest
  test "should transfer session solves to new user" do
    # Create a solve without a user and store it in the session
    problem = problems(:one)
    assert_difference("Solve.count", 1) do
      post solves_url, params: { solve: { problem_id: problem.id, tile: "7m" } }
    end
    # Verify the solve is created and stored in session
    assert_response :redirect
    solve = Solve.last
    assert_nil solve.user_id
    assert_includes session[:solve_ids], solve.id

    # Now create a user
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          email_address: "solve_transfer@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    # Verify the solve is now associated with the new user
    solve.reload
    assert_equal User.find_by(email_address: "solve_transfer@example.com").id, solve.user_id

    # Verify the session no longer contains the solve ID
    assert_nil session[:solve_ids]
  end

  test "should handle empty session solves when creating user" do
    # Make sure session has no solve IDs
    get root_url
    assert_nil session[:solve_ids]

    # Create a user
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          email_address: "no_solves@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    # Verify user is created successfully
    assert_redirected_to new_session_path
    assert_equal "Account created successfully!", flash[:notice]
  end
end
