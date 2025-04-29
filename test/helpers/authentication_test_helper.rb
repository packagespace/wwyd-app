module AuthenticationTestHelper

  # Helper method to sign in a user in integration tests
  def sign_in_as(email, password = "password")
    post session_url, params: {email_address: email, password: password}
  end

  # Helper method to assert that a user is signed in
  def assert_signed_in
    assert cookies[:session_id].present? && cookies[:session_id] != "", "Expected user to be signed in"
  end

  # Helper method to assert that a user is signed out
  def assert_signed_out
    assert cookies[:session_id].blank?, "Expected user to be signed out"
  end

  # Helper method to sign in a user in system tests
  def system_sign_in_as(email, password = "password")
    visit new_session_path
    fill_in "email_address", with: email
    fill_in "password", with: password
    click_button "Sign in"
  end
end
