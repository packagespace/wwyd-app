require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_password_url
    assert_response :success
    assert_select "h1", "Forgot your password?"
  end

  test "should create password reset" do
    post passwords_url, params: {email_address: @user.email_address}

    assert_enqueued_email_with PasswordsMailer, :reset, args: [@user]

    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "should not reveal if email address doesn't exist" do
    post passwords_url, params: {email_address: "nonexistent@example.com"}
    assert_redirected_to new_session_path
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
    assert_no_emails
  end

  test "should get edit with valid token" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)

    get edit_password_url(token)
    assert_response :success
    assert_select "h1", "Update your password"
  end

  test "should redirect to new password path with invalid token" do
    get edit_password_url("invalid_token")
    assert_redirected_to new_password_path
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
  end

  test "should update password with valid token and matching passwords" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)

    patch password_url(token), params: {password: "newpassword", password_confirmation: "newpassword"}
    assert_redirected_to new_session_path
    assert_equal "Password has been reset.", flash[:notice]

    # Verify the password was actually changed
    user.reload
    assert user.authenticate("newpassword")
  end

  test "should not update password with mismatched passwords" do
    user = users(:one)
    token = user.generate_token_for(:password_reset)

    patch password_url(token), params: {password: "newpassword", password_confirmation: "different"}
    assert_redirected_to edit_password_path(token)
    assert_equal "Passwords did not match.", flash[:alert]
  end
end
