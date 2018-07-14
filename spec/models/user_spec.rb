require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is a valid user' do
    user = build(:user)
    expect(user.valid?).to be_truthy
  end

  it 'is invalid without username' do
    user = build(:user, username: nil)
    expect(user).to have(1).errors_on(:username)
  end

  it 'is invalid without email' do
    user = build(:user, email: nil)
    expect(user).to have(1).errors_on(:email)
  end
end
