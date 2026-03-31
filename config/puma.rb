workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))
threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
threads threads_count, threads_count

bind        "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"
environment ENV.fetch('RAILS_ENV', 'production')

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
