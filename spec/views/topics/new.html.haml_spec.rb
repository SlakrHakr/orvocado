require 'rails_helper'

RSpec.describe "topics/new.html.haml", type: :view do
  let(:tags) { [] }

  before do
    assign(:tags, tags)

    render
  end

  it 'contains topic field' do
    expect(rendered).to have_selector('//textarea[name=topic]')
  end

  it 'contains tags field' do
    expect(rendered).to have_selector('//select[name=tags\[\]]')
  end

  it 'contains first position field' do
    expect(rendered).to have_selector('//input[name=first_position]')
  end

  it 'contains second position field' do
    expect(rendered).to have_selector('//input[name=second_position]')
  end

  it 'contains submit button' do
    expect(rendered).to have_selector('//input[type=submit]')
  end
end
