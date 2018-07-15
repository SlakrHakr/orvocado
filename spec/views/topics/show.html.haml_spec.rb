require 'rails_helper'

RSpec.describe "topics/show.html.haml", type: :view do
  let!(:position_one) { create(:position, description: 'heres-position-one') }
  let!(:position_two) { create(:position, description: 'heres-position-two') }
  let!(:topic) { create(:topic, position_one: position_one.id, position_two: position_two.id) }
  let!(:tag) { create(:tag, topic_id: topic.id) }
  let!(:reason_one) { create(:reason, position_id: position_one.id, description: 'heres-position-one-reason') }
  let!(:reason_two) { create(:reason, position_id: position_two.id, description: 'heres-position-two-reason') }

  before do
    assign(:topic, topic)

    render
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

  it 'contains first position reasons' do
    position_one.reasons.each do |reason|
      expect(rendered).to have_text(reason.description)
    end
  end

  it 'contains second position reasons' do
    position_two.reasons.each do |reason|
      expect(rendered).to have_text(reason.description)
    end
  end
end
