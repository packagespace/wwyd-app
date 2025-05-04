module SessionTestHelper
  def sign_in_as(user)
    Current.session = user.sessions.create!

    ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
      cookie_jar.signed[:session_id] = Current.session.id
      cookies[:session_id] = cookie_jar[:session_id]
    end
  end

  def sign_out
    Current.session&.destroy!
    cookies.delete(:session_id)
  end

  def assert_signed_in
    assert cookies[:session_id].present? && cookies[:session_id] != "", "Expected user to be signed in"
  end

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
