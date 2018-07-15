require 'rails_helper'

RSpec.feature 'Select a topic position', type: :feature, js: true do
  let(:user) { build(:user) }

  before do
    DatabaseCleaner.clean_with(:truncation)

    position_one, position_two = create_list(:position, 2)
    create(:topic, position_one: position_one.id, position_two: position_two.id)

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

    context 'when on home page' do
      scenario 'User successfully selects a position' do
        find('.topic-side.topic-side-left').click
        wait_for_ajax
        fill_in 'reason', with: 'heres-a-reason'
        find('button[type=submit]').click
        wait_for_ajax
        find('.topic-side.topic-side-left.selected')
      end
    end

    context 'when on topic page' do
      before do
        find('.topic-description').click
        expect(current_path).to eq topic_path(id: 1)
      end

      scenario 'User successfully selects a position' do
        find('.topic-side.topic-side-left').click
        wait_for_ajax
        fill_in 'reason', with: 'heres-a-reason'
        find('button[type=submit]').click
        wait_for_ajax
        find('.topic-side.topic-side-left.selected')
      end
    end
  end

  context 'when user is not logged in' do
    scenario 'User is redirected to login page' do
      find('.topic-side.topic-side-left').click
      sleep 5 # fixed intermittent issues most likely around speed to transition to new page
      expect(current_path).to eq new_user_session_path
    end
  end
end
