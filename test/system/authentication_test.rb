require "application_system_test_case"
# todo move these tests and assertions to sessions controller?
class AuthenticationTest < ApplicationSystemTestCase
  test "user can sign in with valid credentials" do
    system_sign_in_as users(:one).email_address

    assert_current_path root_path

    assert_text users(:one).email_address
    assert_text "Sign out"
    assert_no_text "Sign in"
    assert_no_text "Sign up"
  end

  test "user cannot sign in with invalid credentials" do
    system_sign_in_as users(:one).email_address, "wrong_password"

    assert_current_path new_session_path

    assert_text "Try another email address or password"

    assert_no_text users(:one).email_address
    assert_text "Sign in"
    assert_text "Sign up"
  end

  test "user can sign out" do
    system_sign_in_as users(:one).email_address

    assert_text users(:one).email_address

    click_button "Sign out"

    assert_current_path new_session_path
    assert_no_text users(:one).email_address
    assert_text "Sign in"
    assert_text "Sign up"
  end
end
