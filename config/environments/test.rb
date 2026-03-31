Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = false
  config.public_file_server.enabled = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr

  # Disable rate limiting in tests so throttle counts don't bleed between cases
  config.after_initialize { Rack::Attack.enabled = false }
end
