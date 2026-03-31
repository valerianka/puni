ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'webmock/minitest'

# Block all outgoing HTTP in tests; allow localhost for Selenium ↔ ChromeDriver traffic
WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  fixtures :all

  # Convenience: build a realistic 511 API response body
  def mock_511_response(vehicles: [{ route_id: 'N', lat: 37.7649, lng: -122.4194 }])
    entities = vehicles.map do |v|
      {
        'Vehicle' => {
          'Trip' => { 'RouteId' => v[:route_id] },
          'Position' => { 'Latitude' => v[:lat], 'Longitude' => v[:lng] }
        }
      }
    end
    { 'Entities' => entities }.to_json
  end

  # Stub the 511 API to return the given vehicles (call before any request that
  # triggers MunisController#vehicles).
  def stub_511_api(vehicles: [{ route_id: 'N', lat: 37.7649, lng: -122.4194 }])
    stub_request(:get, /api\.511\.org.*VehiclePositions/)
      .to_return(status: 200,
                 body: mock_511_response(vehicles: vehicles),
                 headers: { 'Content-Type' => 'application/json' })
  end
end
