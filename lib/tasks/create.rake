namespace :create do

  desc "Create department"
  task :department => :environment do

    name = ENV['NAME'].dup
    users = ENV['USERS'].dup

    if name.nil? or users.nil?
      warn "Usage: rake create:department NAME=... USERS=all"
    else
      d = Department.create!(name: name)
      if users == 'all'
        d.users << User.all
        d.save!
      else
        raise NotImplementedError
      end
    end
  end

  desc "Create user"
  task :user => :environment do

    email = ENV['EMAIL'].dup
    password = ENV['PASSWORD'].dup

    if email.nil? or password.nil?
      warn "Usage: rake create:user EMAIL=... PASSWORD=..."
    else
      User.create!(email: email.dup, password: password).dup
    end
  end

end
