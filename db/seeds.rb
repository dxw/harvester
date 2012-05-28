# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
  ['C', 'Citizen'],
  ['B', 'Business'],
  ['S', 'Specialist'],
  ['G', 'Inside Government'],
  ['A', 'Archive'],
  ['H', 'On hold'],
].each do |attr|
  Attr.create(name: attr[0], description: attr[1])
end
