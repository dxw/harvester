department = Department.create!(name: 'Ministry of Peas')

department.users << User.create!(email: 'tom@dxw.com', password: 'foobar')
department.users << User.create!(email: 'harry@dxw.com', password: 'foobar')
department.users << User.create!(email: 'peter.herlihy@digital.cabinet-office.gov.uk', password: 'gdsferretarmy')


vegetables = ['broccoli', 'cabbage', 'potato', 'carrot', 'peas', 'spinach', 'beans', 'peppers', 'sprouts']
dishes = ['chowder', 'soup', 'roasties', 'cassarole', 'mash']


20.times do
  group = Group.create!(name: "#{vegetables.sample} and #{vegetables.sample} #{dishes.sample}")

  rand(20).times do
    name = Faker::Lorem.sentence
    group.pages.create!(name: name, uri: "http://example.com/#{name.gsub(/\s+/, '/').downcase}")
  end

  department.groups << group
end

####

department = Department.create!(name: 'Ministry of Juice')

department.users << User.create!(email: 'kool-aid@dxw.com', password: 'foobar')


vegetables = ['bak-choi', 'lotus root', 'butternut squash']
dishes = ['curry', 'creme brule']


20.times do
  group = Group.create!(name: "#{vegetables.sample} and #{vegetables.sample} #{dishes.sample}")

  rand(20).times do
    name = Faker::Lorem.sentence
    group.pages.create!(name: name, uri: "http://example.com/#{name.gsub(/\s+/, '/').downcase}")
  end

  department.groups << group
end

