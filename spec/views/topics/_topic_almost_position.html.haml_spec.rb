require 'rails_helper'

RSpec.describe "topics/_topic_almost_position.html.haml", type: :view do
  let!(:position_one) { create(:position, description: 'heres-position-one') }
  let!(:position_two) { create(:position, description: 'heres-position-two') }
  let!(:topic) { create(:topic, position_one: position_one.id, position_two: position_two.id) }
  let!(:tag) { create(:tag, topic_id: topic.id) }
  let!(:reason_one) { create(:reason, position_id: position_one.id, description: 'heres-position-one-reason') }
  let!(:reason_two) { create(:reason, position_id: position_two.id, description: 'heres-position-two-reason') }
  let(:selected_position) { position_one }

  before do
    render partial: 'topics/topic_almost_position.html.haml',
           locals: { topic: topic, position: selected_position }
  end

  it 'contains topic description' do
    expect(rendered).to have_text(topic.description)
  end

  it 'contains first topic position' do
    expect(rendered).to have_text(topic.position_one.description)
  end

  it 'contains second topic position' do
    expect(rendered).to have_text(topic.position_two.description)
  end

  it 'contains topic tags' do
    topic.tags.each do |tag|
      expect(rendered).to have_text(tag.name)
    end
  end

  it 'contains custom reason field' do
    expect(rendered).to have_selector('//textarea')
  end

  it 'contains submit button' do
    expect(rendered).to have_selector('//button[type=submit]')
  end

  context 'when position one selected' do
    let(:selected_position) { position_one }

    it 'contains position one reason' do
      expect(rendered).to have_text(reason_one.description)
    end
  end

  context 'when position two selected' do
    let(:selected_position) { position_two }

    it 'contains position two reason' do
      expect(rendered).to have_text(reason_two.description)
    end
  end
end
