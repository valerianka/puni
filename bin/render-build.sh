#!/usr/bin/env bash
set -o errexit

export EXECJS_RUNTIME=Node

bundle install
bundle exec rake assets:clobber
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rails db:prepare
bundle exec rails db:migrate
