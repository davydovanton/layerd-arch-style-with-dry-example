# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.0'

# dependency managment
gem 'dry-system', '0.25'
gem 'zeitwerk'

# business logic section
gem 'dry-monads', '1.3'
gem 'dry-schema', '1.9'

# persistance layer
gem 'dry-types', '1.5'
gem 'dry-struct', '1.0'

# Other
# gem 'bigdecimal', '1.4.2'
gem 'rake'

# fitness functions
gem 'parser'

group :development do
end

group :test, :development do
  gem 'dotenv', '~> 2.4'

  # style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
end

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end
