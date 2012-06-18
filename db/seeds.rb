# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
  ['Ci', 'Citizen'],
  ['Bz', 'Business'],
  ['Sp', 'Specialist'],
  ['IG', 'Inside Government'],
  ['Ar', 'Archive'],
  ['??', 'On hold'],
].each do |attr|
  Attr.create(name: attr[0], description: attr[1])
end
