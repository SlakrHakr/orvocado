# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(1..30).each do |index|
  topic = [
    { description: 'Which is the superior fruit?', position_one: 'Avacado', position_two: 'Orange' },
    { description: 'Should the death penalty be allowed?', position_one: 'Yes', position_two: 'No' },
    { description: 'Drugs should be legalized in the United States', position_one: 'Agree', position_two: 'Disagree' }
  ].sample

  result_position_one = Position.create(description: topic[:position_one])
  result_position_two = Position.create(description: topic[:position_two])
  result_topic = Topic.create(description: topic[:description], position_one: result_position_one.id, position_two: result_position_two.id)

  if [true, false].sample
    Tag.create(topic_id: result_topic.id, name: 'tag-example')

    if [true, false, false, false].sample
      Tag.create(topic_id: result_topic.id, name: 'another-tag')
    end
  end
end
