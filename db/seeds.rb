# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times { |i| Position.create(description: "Position #{i + 1}") }
50.times { |i| Topic.create(description: "Description #{i + 1}", position_one: i + 1, position_two: 100 - i) }

User.create(name: 'SlakrHakr', password: 'password', email: 'leedeboom@gmail.com')

22.times { |i| Reason.create(position_id: 49, description: "Reason #{i + 1}") }
3.times { |i| Reason.create(position_id: 52, description: "Different Reason #{i + 1}") }

UserPosition.create(user_id: 1, position_id: 49)
UserPosition.create(user_id: 1, position_id: 56)

Tag.create(topic_id: 50, name: 'tag-example')
