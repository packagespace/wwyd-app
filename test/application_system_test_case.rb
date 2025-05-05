require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver(:selenium) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(
      unhandled_prompt_behavior: "ignore"
    )
    Capybara::Selenium::Driver.new(app, options: options)
  end
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
