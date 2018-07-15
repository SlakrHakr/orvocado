require 'rails_helper'

RSpec.feature 'Compare current views against history', type: :feature, js: true do
  before do
    DatabaseCleaner.clean_with(:truncation)

    user = create(:user)
    (0..100).each do |index|
      position_one = create(:position)
      position_two = create(:position)
      create(:topic, position_one: position_one.id, position_two: position_two.id)
      create_list(:reason, 50, user_id: user.id, position_id: position_one.id)
      create_list(:reason, 3, user_id: user.id, position_id: position_two.id)
    end

    visit root_path
  end

  scenario 'visual regression testing' do
    if ENV['VISUAL_REGRESSION_RESET'].present?
      # Useful after any modification to the history.yaml configuration and/or mocks above
      puts 'Resetting base images...'
      success = system('cd spec/visual_regression && wraith info && wraith history configs/history.yaml')
      raise 'Failed to capture new base images.' unless success
    end

    success = system('cd spec/visual_regression && wraith latest configs/history.yaml')
    raise 'One or more view regression tests failed. Use VISUAL_REGRESSION_RESET environment variable if changes were expected.' unless success
  end
end
