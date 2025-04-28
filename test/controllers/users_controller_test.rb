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
