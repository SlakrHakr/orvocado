require 'rails_helper'

RSpec.describe Reason, type: :model do
  let!(:position) { create(:position) }

  it 'is a valid reason' do
    reason = build(:reason, position_id: position.id)
    expect(reason.valid?).to be_truthy
  end

  it 'is invalid without position' do
    reason = build(:reason, position_id: nil)
    expect(reason).to have(1).errors_on(:position_id)
  end

  it 'is invalid without description' do
    reason = build(:reason, position_id: position.id, description: nil)
    expect(reason).to have(1).errors_on(:description)
  end

  it 'is valid without score' do
    reason = build(:reason, position_id: position.id, score: nil)
    expect(reason.valid?).to be_truthy
  end
end
