source 'https://rubygems.org'

gem 'rails', '~> 7.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Terser as compressor for JavaScript assets
gem 'terser'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'bootstrap-sass'
gem 'will_paginate', '~> 3.3'
gem 'betterlorem', '~> 0.1.2'
gem 'bootstrap-will_paginate', '~> 0.0.10'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 2.0', group: :doc

gem 'puma', '~> 6.0'
gem 'rack-attack', '~> 6.7'
gem 'sentry-ruby', '~> 5.0'
gem 'sentry-rails', '~> 5.0'
gem 'bootsnap', '>= 1.4.2', require: false
# Stdlib gems moved out in Ruby 3.4+; required by Rails + Ruby 4.0
gem 'mutex_m'
gem 'bigdecimal'
gem 'tsort'
gem 'irb'
gem 'ostruct'
gem 'benchmark'

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug'
  gem 'rubocop', '~> 1.65', require: false
  gem 'rubocop-rails', '~> 2.25', require: false
  gem 'rubocop-performance', '~> 1.21', require: false
  gem 'webmock', '~> 3.23'
end

group :test do
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.27'
end

group :development do
  gem 'web-console', '~> 4.2'
end

group :production do
  gem 'pg', '~> 1.1'
end
