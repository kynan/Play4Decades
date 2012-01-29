require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'
gem 'rails', '3.2.1'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
group :development do
  gem 'sqlite3'
  gem "haml-rails", ">= 0.3.4"
  gem "nifty-generators"
  gem 'ruby-debug19'
end
group :test do
  gem 'sqlite3'
  gem "factory_girl_rails", ">= 1.4.0"
  gem "database_cleaner", ">= 0.7.0"
  gem "capybara", ">= 1.1.2"
  gem "launchy", ">= 2.0.5"
  gem "cucumber-rails", ">= 1.2.0"
  gem "mocha"
end
group :production do
  gem "pg"
end
gem 'jquery-rails'
gem "haml", ">= 3.1.2"
gem "devise", ">= 1.5.0"
gem "rspec-rails", ">= 2.8.0.rc1", :group => [:development, :test]

