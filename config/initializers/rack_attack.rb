class Rack::Attack
  # Use the Rails cache store (memory in dev/test, configure Redis in production
  # if running multiple Puma workers to share state across processes)
  Rack::Attack.cache.store = Rails.cache

  # ---- Throttles -------------------------------------------------------

  # Rating submissions: max 5 per IP per 10 minutes
  throttle('ratings/ip', limit: 5, period: 10.minutes) do |req|
    req.ip if req.post? && req.path == '/leaderboard'
  end

  # ---- Response for throttled requests ---------------------------------

  self.throttled_responder = lambda do |req|
    match_data = req.env['rack.attack.match_data']
    retry_after = match_data[:period] - (Time.now.to_i % match_data[:period])

    [
      429,
      {
        'Content-Type' => 'text/html',
        'Retry-After' => retry_after.to_s
      },
      ["<h2>Too many ratings submitted.</h2><p>Please wait #{retry_after / 60} minute(s) and try again.</p>"]
    ]
  end
end
