# Rails Upgrade Notes — Completed ✅

## Current State

**Last Updated**: March 31, 2026
**Ruby**: 4.0.2 (Homebrew — `/opt/homebrew/Cellar/ruby/4.0.2`)
**Rails**: 7.2
**Deployed on**: Render (web service + PostgreSQL)
**Git remote**: `valerianka` → `git@github.com:valerianka/puni.git`

---

## Upgrade History

### Rails 5.2 → 7.2 (March 2026)

- Upgraded Rails from 5.2 to 7.2 to support Ruby 4.0
- Removed CoffeeScript and jQuery — rewritten in vanilla JS with page-specific modules
- Removed `require_tree` from asset pipeline
- Split JS into page-specific entry points
- Dropped Spring (caused test failures with Rails 7.2, not needed)
- Added stdlib gems required by Ruby 4.0: `mutex_m`, `bigdecimal`, `tsort`, `irb`, `ostruct`, `benchmark`

---

## How to Run Locally

RVM may interfere — Homebrew Ruby 4.0.2 must take precedence. Add to `~/.zshrc`:

```bash
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
```

Then:

```bash
bundle exec rails server
```

Server starts on **http://localhost:3000**

---

## Running Tests

```bash
bundle exec rails test
```

48 tests (41 unit/controller + 7 system), all passing.

---

## Database

- **Development/Test**: SQLite (`db/development.sqlite3`, `db/test.sqlite3`)
- **Production**: PostgreSQL via `DATABASE_URL` env var (set by Render)
- **Migrations**: Run automatically on deploy via `bin/render-build.sh`

---

## Deployment (Render)

Build script: `bin/render-build.sh`

```bash
bundle install
bundle exec rake assets:precompile
bundle exec rails db:prepare
bundle exec rails db:migrate
```

Start command (Procfile): `bundle exec rails db:prepare && bundle exec puma -C config/puma.rb`

**Required env vars on Render:**
- `DATABASE_URL` — set automatically by Render PostgreSQL
- `RAILS_ENV=production`
- `RAILS_MASTER_KEY` — from `config/master.key`
- `MUNI_511_API_KEY` — 511.org API key for real-time bus data
- `WEB_CONCURRENCY=1` — keeps Rack::Attack MemoryStore working correctly

---

## Security Hardening (March 2026)

- `force_ssl = true` in production
- Session cookies: `secure`, `httponly`, `same_site: :strict`
- Rack::Attack: rate limiting (3 submissions per IP per 10 min) on `/leaderboard`
- Strong parameters in `MunisController`
- `filter_parameters` covers `:password`, `:api_key`, `:token`, `:secret`

---

## Database Efficiency (March 2026)

- Added unique index on `munis.route_name` (fast lookups + DB-level uniqueness)
- `update_averages` uses SQL `AVG()` instead of Ruby iteration
- `sorted_munis` uses `ORDER BY` in SQL instead of `Muni.all` + Ruby sort
- `find_or_create_by` race condition handled with `RecordNotUnique` rescue

---

## Known Issues

### RVM in PATH
RVM may shadow Homebrew Ruby. Fix by adding to `~/.zshrc`:
```bash
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
```

