require "application_system_test_case"
class AuthenticationTest < ApplicationSystemTestCase
  test "user can sign in with valid credentials" do
    system_sign_in_as users(:one)

    assert_current_path root_path

    assert_text users(:one).email_address
    assert_text "Sign out"
    assert_no_text "Sign in"
    assert_no_text "Sign up"
  end

  test "user cannot sign in with invalid credentials" do
    visit new_session_path
    fill_in "email_address", with: users(:one).email_address
    fill_in "password", with: "wrong_password"
    click_button "Sign in"

    assert_current_path new_session_path

    assert_text "Try another email address or password"

    assert_no_text users(:one).email_address
    assert_text "Sign in"
    assert_text "Sign up"
  end

  test "user can sign out" do
    system_sign_in_as users(:one)

    assert_text users(:one).email_address

    click_button "Sign out"

    assert_current_path root_path
    assert_text "Sign in"
    assert_text "Sign up"
    assert_no_text users(:one).email_address
  end
end
