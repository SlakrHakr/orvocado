require 'rails_helper'

RSpec.describe "layouts/_banner.html.haml", type: :view do
  let!(:user) { create(:user) }
  let(:is_user_signed_in) { false }

  before do
    allow(controller).to receive(:user_signed_in?).and_return(is_user_signed_in)
    allow(controller).to receive(:current_user).and_return(user)

    render
  end

  it 'contains link to home' do
    expect(rendered).to have_link('', href: root_path)
  end

  context 'when user is logged in' do
    let(:is_user_signed_in) { true }

    it "contains link to user's created topics" do
      expect(rendered).to have_link('Created Topics', href: user_created_path(user_id: user.id))
    end

    it "contains link to user's past positions" do
      expect(rendered).to have_link('Past Positions', href: user_positions_path(user_id: user.id))
    end

    it "contains user's name" do
      expect(rendered).to have_text(user.username)
    end

    it 'contains link to edit user profile' do
      expect(rendered).to have_link('Edit Profile', href: edit_user_registration_path)
    end

    it 'contains link to logout' do
      expect(rendered).to have_link('Logout', href: destroy_user_session_path)
    end
  end

  context 'when user is not logged in' do
    let(:is_user_signed_in) { false }

    it 'contains link to login' do
      expect(rendered).to have_link('Login', href: new_user_session_path)
    end
  end
end
