department = Department.create!(name: 'Ministry of Peas')

department.users << User.create!(email: 'tom@dxw.com', password: 'foobar')
department.users << User.create!(email: 'harry@dxw.com', password: 'foobar')
department.users << User.create!(email: 'lee@dxw.com', password: 'foobar')
department.users << User.create!(email: 'peter.herlihy@digital.cabinet-office.gov.uk', password: 'gdsferretarmy')
