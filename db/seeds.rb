# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# (1..30).each do |index|
#   topic = [
#     { description: 'Which is the superior fruit?', position_one: 'Avacado', position_two: 'Orange' },
#     { description: 'Should the death penalty be allowed?', position_one: 'Yes', position_two: 'No' },
#     { description: 'Drugs should be legalized in the United States', position_one: 'Agree', position_two: 'Disagree' }
#   ].sample
#
#   result_position_one = Position.create(description: topic[:position_one])
#   result_position_two = Position.create(description: topic[:position_two])
#   result_topic = Topic.create(description: topic[:description], position_one: result_position_one.id, position_two: result_position_two.id)
#
#   if [true, false].sample
#     Tag.create(topic_id: result_topic.id, name: 'tag-example')
#
#     if [true, false, false, false].sample
#       Tag.create(topic_id: result_topic.id, name: 'another-tag')
#     end
#   end
# end


page = Nokogiri::HTML(open('http://www.procon.org'))
links = page.css('a')

unique_links = []
links.each do |link|
  if link['title'].present?
    words = link['title'].split(' ')
    prev_word = ''
    title_issue = false
    words.each do |word|
      if word.gsub('?', '').downcase == prev_word.gsub('?', '').downcase
        title_issue = true
        break
      end
      prev_word = word
    end

    if not title_issue
      found = false
      unique_links.each do |ul|
        if ul['title'].downcase == link['title'].downcase
          found = true
          break
        end
      end

      unique_links.push(link) unless found
    end
  end
end

unique_links.each do |link|
  if (link['href'] != '#' && link['title'].present?)
    begin
      next_page = Nokogiri::HTML(open(link['href']))
      pro_column = next_page.css('#newblue-pro-column-2')
      con_column = next_page.css('#newblue-con-column-2')

      if (pro_column.length > 0 && con_column.length > 0)
        topic_description = link['title']

        result_position_one = Position.create(description: 'Yes')
        result_position_two = Position.create(description: 'No')
        result_topic = Topic.create(description: topic_description, position_one: result_position_one.id, position_two: result_position_two.id)

        tags = []
        tags.push('america') if topic_description.downcase.include?('president')
        tags.push('politics') if topic_description.downcase.include?('president')
        tags.push('america') if topic_description.downcase.include?('united states')
        tags.push('america') if topic_description.downcase.include?('america')
        tags.push('education') if topic_description.downcase.include?('education')
        tags = tags.uniq

        tags.each do |tag|
          Tag.create(topic_id: result_topic.id, name: tag)
        end

        pro_reasons = next_page.css('.newblue-pro-quote-box').map{ |div| div.text.strip }
        con_reasons = next_page.css('.newblue-con-quote-box').map{ |div| div.text.strip }

        pro_reasons.each do |reason|
          Reason.create(position_id: result_position_one.id, description: reason.gsub(/\[[0-9]+\]/, ''))
        end

        con_reasons.each do |reason|
          Reason.create(position_id: result_position_two.id, description: reason.gsub(/\[[0-9]+\]/, ''))
        end
      end
    rescue
      # dont care about links that dont work
    end
  end
end


# the classic question
result_position_one = Position.create(description: 'Avacado')
result_position_two = Position.create(description: 'Orange')
result_topic = Topic.create(description: 'Which is the superior fruit?', position_one: result_position_one.id, position_two: result_position_two.id)
Tag.create(topic_id: result_topic.id, name: 'fruit')
Tag.create(topic_id: result_topic.id, name: 'controversial')
