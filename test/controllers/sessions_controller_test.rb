require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_session_url
    assert_response :success
    assert_select "h1", "Sign in"
  end

  test "should create session with valid credentials" do
    sign_in_as users(:one).email_address
    assert_redirected_to root_url
    assert_signed_in
  end

  test "should not create session with invalid credentials" do
    sign_in_as users(:one).email_address, "wrong_password"
    assert_redirected_to new_session_path
    assert_signed_out
    assert_not_nil flash[:alert]
  end

  test "should destroy session" do
    # First login
    sign_in_as users(:one).email_address
    assert_signed_in
    
    # Then logout
    delete session_url
    assert_redirected_to new_session_path
    assert_signed_out
  end
end
