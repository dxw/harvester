desc "Import data"
task :import => :environment do

  require Rails.root.join('lib','import','import')

  uri = ENV['IMPORT_URI']
  if uri.nil?
    puts 'Usage: IMPORT_URI=... rake import'
    exit 1
  end
  Import.go uri

end
