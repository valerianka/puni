Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', nil)
  config.enabled_environments = %w[production]
  config.breadcrumbs_logger = [:active_support_logger]
end
