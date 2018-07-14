require 'rails_helper'

RSpec.describe Position, type: :model do
  it 'is a valid position' do
    position = build(:position)
    expect(position.valid?).to be_truthy
  end

  it 'is invalid without description' do
    position = build(:position, description: nil)
    expect(position).to have(1).errors_on(:description)
  end
end
