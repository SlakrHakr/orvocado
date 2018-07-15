require 'rails_helper'

RSpec.describe "layouts/application.html.haml", type: :view do
  before do
    stub_template 'layouts/_banner.html.haml' => ''

    render
  end

  it 'renders banner' do
    expect(view).to render_template('layouts/_banner')
  end
end
