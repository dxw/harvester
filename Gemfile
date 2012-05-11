source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'twitter-bootstrap-rails'
  gem 'underscore-rails'
end

gem 'jquery-rails'

gem 'devise'
gem 'haml'
gem 'rails3-jquery-autocomplete'
gem 'couchrest'
# Add the gem so we have the dependencies, but don't load it
gem 'google-spreadsheet-ruby', require: 'google_spreadsheet'
gem 'nokogiri', '< 1.5.1' # For google-spreadsheet-ruby
gem 'progressbar', require: false

gem 'faker'

group :production do
  gem 'mysql2'
  gem 'newrelic_rpm'
end

group :test do 
  gem 'factory_girl_rails'
  gem 'simplecov', require: false
end

group :development do
  gem 'rspec-rails'
  gem 'webrat'
  gem 'ruby-prof'
end
