user1 = User.create!(email: 'tom@dxw.com', password: 'foobar')
user2 = User.create!(email: 'harry@dxw.com', password: 'foobar')
user3 = User.create!(email: 'peter.herlihy@digital.cabinet-office.gov.uk', password: 'gdsferretarmy')

department = Department.create!(name: 'Ministry of Peas')

group1 = Group.create!(name: 'Broccoli')
group2 = Group.create!(name: 'Cabbage')

department.users << user1
department.users << user2
department.users << user3
department.groups << group1
department.groups << group2

(1..9).each do |a|
  page = group1.pages.create!(name: 'Link %d' % a, uri: 'http://example.org/%d' % a)
end

(2..20).each do |a|
  page = group2.pages.create!(name: '%d bottles of beer on the wall' % a, uri: 'http://example.org/%d' % a)
end
