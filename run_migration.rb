#!/usr/bin/env ruby
# Simple migration runner to work around Rails command dispatch issues

require_relative 'config/environment'
require 'rake'

# Load and run migrations
Rake.application.init('rake')
Rake.application.load_rakefile
Rake.application['db:migrate'].invoke
