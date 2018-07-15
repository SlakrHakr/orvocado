require 'rails_helper'

RSpec.feature 'Create user account', type: :feature, js: true do
  let(:user) { build(:user) }

  before do
    DatabaseCleaner.clean_with(:truncation)
    visit root_path
  end

  scenario 'User successfully creates an account' do
    find("a[href='#{new_user_session_path}']").click
    find("a[href='#{new_user_registration_path}']").click
    fill_in 'user_username', with: user.username
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    find('input[type=submit]').click

    expect(current_path).to eq root_path
  end
end
