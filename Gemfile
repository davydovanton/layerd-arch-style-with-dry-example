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
gem 'sqlite3'

# HTTP transport layer
gem 'hanami-api'
gem 'hanami-controller', git: 'https://github.com/hanami/controller.git', tag: 'v2.0.0.beta1'
gem 'hanami-validations', git: 'https://github.com/hanami/validations.git', tag: 'v2.0.0.beta1'
gem 'puma', '~> 3.12.4'

# other transport layers
# ...

# Other
# gem 'bigdecimal', '1.4.2'
gem 'rake'

# Monitoring and logging
gem 'rollbar'
gem 'semantic_logger'

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
