# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.1"

gem 'dry-system', '~> 0.25.0'
gem 'rake'

# fitness functions
gem 'parser'

gem 'zeitwerk', '~> 2.6'

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
