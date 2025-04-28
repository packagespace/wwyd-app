require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  test "user can sign in with valid credentials" do
    # Sign in using the helper
    system_sign_in_as users(:one).email_address
    
    # Assert that we're redirected to the root page
    assert_current_path root_path
    
    # Assert that the user is signed in
    assert_text users(:one).email_address
    assert_text "Sign out"
    assert_no_text "Sign in"
    assert_no_text "Sign up"
  end
  
  test "user cannot sign in with invalid credentials" do
    # Sign in with invalid credentials
    system_sign_in_as users(:one).email_address, "wrong_password"
    
    # Assert that we're redirected back to the sign in page
    assert_current_path new_session_path
    
    # Assert that an error message is displayed
    assert_text "Try another email address or password"
    
    # Assert that the user is not signed in
    assert_no_text users(:one).email_address
    assert_text "Sign in"
    assert_text "Sign up"
  end
  
  test "user can sign out" do
    # Sign in first
    system_sign_in_as users(:one).email_address
    
    # Assert that the user is signed in
    assert_text users(:one).email_address
    
    # Sign out
    click_button "Sign out"
    
    # Assert that the user is signed out
    assert_current_path new_session_path
    assert_no_text users(:one).email_address
    assert_text "Sign in"
    assert_text "Sign up"
  end
  
  test "navigation between sign in and sign up pages" do
    # Start at sign in page
    visit new_session_path
    
    # Navigate to sign up page using the link in the form
    find("div.mt-6 a", text: "Sign up").click
    assert_current_path new_user_path
    
    # Navigate back to sign in page using the nav link
    find("nav a", text: "Sign in").click
    assert_current_path new_session_path
  end
end
