class Rack::Attack
  # MemoryStore works correctly with a single Puma worker (WEB_CONCURRENCY=1).
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # ---- Throttles -------------------------------------------------------

  # Rating submissions: max 3 per IP per 10 minutes
  throttle('ratings/ip', limit: 3, period: 10.minutes) do |req|
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
