require "rails_helper"

RSpec.feature "Widget management", :type => :feature do
  scenario "User creates a new widget" do
    visit "/orple/topics"
    page.save_screenshot 'screenshot.png'
    # page.save_screenshot('screen.png', full: true)

    # screenshot_and_save_page
    # screenshot_and_open_image
  end
end