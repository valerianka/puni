require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1280, 900] do |options|
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    options.add_argument('--disable-gpu')
  end

  private

  # Grant the geolocation permission and set fake SF coordinates via CDP,
  # so the page's getCurrentPosition() resolves immediately without a real
  # GPS fix.  Must be called BEFORE visiting the page.
  def override_geolocation(lat: 37.7749, lng: -122.4194)
    page.driver.browser.execute_cdp(
      'Browser.grantPermissions',
      permissions: ['geolocation']
    )
    page.driver.browser.execute_cdp(
      'Emulation.setGeolocationOverride',
      latitude: lat,
      longitude: lng,
      accuracy: 10
    )
  end
end
