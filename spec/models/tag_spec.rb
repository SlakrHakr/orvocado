require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:position_one) { create(:position, id: 1) }
  let!(:position_two) { create(:position, id: 2) }
  let!(:topic) { create(:topic) }

  it 'is a valid tag' do
    tag = build(:tag, topic_id: topic.id)
    expect(tag.valid?).to be_truthy
  end

  it 'is invalid without name' do
    tag = build(:tag, topic_id: topic.id, name: nil)
    expect(tag).to have(1).errors_on(:name)
  end

  it 'is invalid without topic' do
    tag = build(:tag, topic_id: nil)
    expect(tag).to have(1).errors_on(:topic_id)
  end
end
