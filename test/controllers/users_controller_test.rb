require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test "should get new" do
    get new_user_url
    assert_response :success
    assert_select "h1", "Sign up"
  end

  test "should create user with valid attributes" do
    assert_difference("User.count") do
      post users_url, params: {
        user: {
          email_address: "new@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to root_url
    assert_signed_in
    assert_equal "Account created successfully!", flash[:notice]
  end

  test "should transfer session solves to new user" do
    # Create a solve without a user and store it in the session
    problem = problems(:one)
    post solves_url, params: { solve: { problem_id: problem.id, tile: "7m" } }
    
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
    assert_redirected_to root_url
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
    assert_redirected_to root_url
    assert_signed_in
    assert_equal "Account created successfully!", flash[:notice]
  end

  test "should not create user with invalid attributes" do
    assert_no_difference("User.count") do
      post users_url, params: {
        user: {
          email_address: "invalid-email",
          password: "password",
          password_confirmation: "different"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_signed_out
  end

  test "should not create user with duplicate email" do
    assert_no_difference("User.count") do
      post users_url, params: {
        user: {
          email_address: users(:one).email_address, # Email from fixtures
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_signed_out
  end
end
