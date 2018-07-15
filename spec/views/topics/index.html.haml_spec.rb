require 'rails_helper'

RSpec.describe "topics/index.html.haml", type: :view do
  let!(:position_one) { create(:position, description: 'heres-position-one') }
  let!(:position_two) { create(:position, description: 'heres-position-two') }
  let!(:topic) { create(:topic, position_one: position_one.id, position_two: position_two.id) }
  let!(:tag) { create(:tag, topic_id: topic.id) }
  let(:topics) { [topic] }

  before do
    assign(:topics, topics)

    allow(view).to receive_messages(will_paginate: nil)
    render
  end

  it 'contains topic description' do
    topics.each do |topic|
      expect(rendered).to have_text(topic.description)
    end
  end

  it 'contains first topic position' do
    topics.each do |topic|
      expect(rendered).to have_text(topic.position_one.description)
    end
  end

  it 'contains second topic position' do
    topics.each do |topic|
      expect(rendered).to have_text(topic.position_two.description)
    end
  end

  it 'contains topic tags' do
    topics.each do |topic|
      topic.tags.each do |tag|
        expect(rendered).to have_text(tag.name)
      end
    end
  end
end
