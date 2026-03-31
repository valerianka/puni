<img src="https://github.com/doloresjoya/puni/blob/master/app/assets/images/puni_logo.png" align="center" width="250px" />

_MUNI Stinks...Rate your ride!_

It's now very simple to rate anything from films and music to shared taxi rides and restaurants. Public transport has so far escaped such scrutiny. 

Puni addresses this problem, giving riders of San Francisco public transport ("Muni") the opportunity to rate their experience and share their Muni horror stories with others.

Application uses geolocation feature to determine user's current location and finds the nearest bus to the point. Also it's possible to manually choose the bus to rate by clicking on the route number's window and choosing from the pins with busses numbers on Google map. The pictures in the beamlights and driver window shows average busses ratings. Each ride is rated in terms of Smell, Cleanliness and Driver mood and users can submit their horror stories that happened during Muni ride. The app then shows leaderboard of the worst Muni route numbers and shows their ratings. 

Real-time bus locations are fetched from the [511.org Transit API](https://511.org/open-data/transit).
Integration with Google Maps shows live Muni locations on the map.

## Tech Stack

- **Ruby** 4.0.2
- **Rails** 7.2
- **PostgreSQL** (production) / SQLite (development & test)
- **Puma** 6 (web server)
- **Bootstrap** 3.4 + SCSS via sass-rails
- **Vanilla JS** — page-specific modules, no jQuery
- **Rack::Attack** — rate limiting
- **Sentry** — error monitoring (production)
- **Google Maps API** — map and geolocation
- **511.org Transit API** — real-time SF Muni bus positions

## Local Setup

**Requirements:** Ruby 4.0.2 via Homebrew, SQLite

If RVM is in your PATH, make sure Homebrew Ruby takes precedence by adding this to `~/.zshrc`:

```bash
export PATH=/opt/homebrew/opt/ruby/bin:$PATH
```

**Install and run:**

```bash
bundle install
bundle exec rails db:create db:migrate
bundle exec rails server
```

App runs at **http://localhost:3000**

**Run tests:**

```bash
bundle exec rails test
bundle exec rails test:system
```

**Environment variables** (optional for local dev):
- `MUNI_511_API_KEY` — 511.org API key for live bus data. Without it the app uses mock bus data.
- `GOOGLE_MAPS_API_KEY` — required for the map to render.

## Contributing

The local setup above is the quickest way to get started. Once you have the app running:

1. Fork the repo and create a branch for your change
2. Write tests for new functionality
3. Make sure `bundle exec rails test` passes
4. Open a pull request against `master`

Bug reports and feature suggestions are welcome via GitHub Issues.

Future development
-------
- Upload photos and videos as part of your rating.
- View a stream of recent ratings and images.
- Auto-send ratings (with submitter's contact details) to the transport authority.
- Integrate with Google Maps to view ratings when planning your route.
- Expand to other cities and countries.

License
-------
See LICENSE.md.

Authors
-------
Puni was created by Dolores Joya, Sara Gilford, Miriam Persley, Kate Bennet and Valerie Gorbik as part of neoHack 2015.
