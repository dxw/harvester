namespace :import do
  desc "Import from couch"
  task :couch => :environment do

    require Rails.root.join('lib','import','couch')

    uri = ENV['IMPORT_URI']
    if uri.nil?
      puts 'Usage: IMPORT_URI=... rake import_couch'
      exit 1
    end
    ImportCouch.go uri

  end

  desc "Import from CSV"
  task :csv => :environment do

    require Rails.root.join('lib','import','csv')

    file = ENV['CSV']
    department = ENV['DEPARTMENT'].to_i
    if file.nil? or department.nil?
      puts 'Usage: rake import_csv CSV=file.csv DEPARTMENT=id'
      exit 1
    end
    ImportCSV.go file, department

  end
end
