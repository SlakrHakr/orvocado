require 'rails_helper'

RSpec.feature 'Create new topic', type: :feature, js: true do
  let(:user) { build(:user) }

  before do
    DatabaseCleaner.clean_with(:truncation)
    visit root_path
  end

  context 'when user is logged in' do
    before do
      find("a[href='#{new_user_session_path}']").click
      find("a[href='#{new_user_registration_path}']").click
      fill_in 'user_username', with: user.username
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      find('input[type=submit]').click
    end

    scenario 'User successfully creates a new topic' do
      find("a[href='#{new_topic_path}']").click
      fill_in 'topic', with: 'heres-a-new-topic'
      fill_in 'first_position', with: 'heres-a-position'
      fill_in 'second_position', with: 'heres-another-position'
      find('div.select-position.left-side').click
      fill_in 'reason', with: 'heres-a-reason'
      find('input[type=submit]').click

      expect(current_path).to eq topic_path(id: 1)
    end
  end

  context 'when user is not logged in' do
    scenario 'User is redirected to login page' do
      find("a[href='#{new_topic_path}']").click
      expect(current_path).to eq new_user_session_path
    end
  end
end
