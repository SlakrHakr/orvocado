require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReasonsHelper. For example:
#
# describe ReasonsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ReasonsHelper, type: :helper do
  describe 'link_urls' do
    context 'when url begins with https' do
      it 'converts urls to proper links to display' do
        input = 'https://www.google.com/'
        output = "<a href='#{input}'>#{input}</a> <br/>"

        expect(helper.link_urls(input)).to eq(output)
      end
    end

    context 'when url begins with http' do
      it 'converts urls to proper links to display' do
        input = 'http://www.google.com/'
        output = "<a href='#{input}'>#{input}</a> <br/>"

        expect(helper.link_urls(input)).to eq(output)
      end
    end
  end
end
