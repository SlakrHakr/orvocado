require 'rails_helper'

RSpec.describe Topic, type: :model do
  let!(:position_one) { create(:position, id: 1) }
  let!(:position_two) { create(:position, id: 2) }

  it 'is a valid topic' do
    topic = build(:topic)
    expect(topic.valid?).to be_truthy
  end

  it 'is invalid without description' do
    topic = build(:topic, description: nil)
    expect(topic).to have(1).errors_on(:description)
  end

  it 'is invalid without first position' do
    topic = build(:topic, position_one: nil)
    expect(topic).to have(1).errors_on(:position_one)
  end

  it 'is invalid without second position' do
    topic = build(:topic, position_two: nil)
    expect(topic).to have(1).errors_on(:position_two)
  end
end
