user = User.create!(email: 'tom@dxw.com', password: 'foobar')

department = Department.create!(name: 'Ministry of Peas')

group = Group.create!(name: 'Broccoli')

department.users << user
department.groups << group

Attribute.create!(name: 'a')
Audience.create!( name: 'a')
Need.create!(     name: 'a')
Attribute.create!(name: 'b')
Audience.create!( name: 'b')
Need.create!(     name: 'b')

(1..9).each do |a|
  page = group.pages.create!(name: 'Link %d' % a, uri: 'http://example.org/%d' % a)
end

Page.first.audiences << Audience.first
