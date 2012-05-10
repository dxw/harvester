desc "Import from couch"
task :import_couch => :environment do

  require Rails.root.join('lib','import','couch')

  uri = ENV['IMPORT_URI']
  if uri.nil?
    puts 'Usage: IMPORT_URI=... rake import_couch'
    exit 1
  end
  ImportCouch.go uri

end

desc "Import from CSV"
task :import_csv => :environment do

  require Rails.root.join('lib','import','csv')

  file = ENV['CSV']
  if file.nil?
    puts 'Usage: CSV=... rake import_csv'
    exit 1
  end
  ImportCSV.go file

end
