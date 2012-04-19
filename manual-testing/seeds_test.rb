department = Department.create!(name: 'Ministry of Peas')

department.users << User.create!(email: 'tom@dxw.com', password: 'foobar')
department.users << User.create!(email: 'harry@dxw.com', password: 'foobar')
department.users << User.create!(email: 'peter.herlihy@digital.cabinet-office.gov.uk', password: 'gdsferretarmy')


vegetables = ['broccoli', 'cabbage', 'potato', 'carrot', 'peas', 'spinach', 'beans', 'peppers', 'sprouts']
dishes = ['chowder', 'soup', 'roasties', 'cassarole', 'mash']
northern_places = ['South Dakota', 'South Africa', 'South Sudan', 'South Korea', 'South Carolina']
southern_places = ['North Dakota', 'North Korea', 'North Carolina']


20.times do
  group = Group.create!(name: "#{vegetables.sample} and #{vegetables.sample} #{dishes.sample}")

  rand(20).times do
    name = Faker::Lorem.sentence
    page = group.pages.create!(name: name, uri: "http://example.com/#{name.gsub(/\s+/, '/').downcase}")
    3.times do
      page.needs.create!(name: northern_places.sample)
    end
    3.times do
      page.audiences.create!(name: southern_places.sample)
    end
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

