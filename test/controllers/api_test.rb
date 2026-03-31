require 'test_helper'

# Tests for the JSON API endpoints that the browser JS consumes.
class ApiTest < ActionDispatch::IntegrationTest
  # ── GET /munis/vehicles ────────────────────────────────────────────────────

  test 'vehicles returns items array with route_id, latitude, longitude' do
    stub_511_api(vehicles: [
                   { route_id: 'N', lat: 37.7649, lng: -122.4194 },
                   { route_id: '38', lat: 37.7796, lng: -122.4477 }
                 ])

    get '/munis/vehicles'

    assert_response :success
    data = response.parsed_body
    assert data.key?('items'), 'response should have an items key'
    assert_equal 2, data['items'].length

    first = data['items'].first
    assert_equal 'N',        first['route_id']
    assert_in_delta 37.7649, first['latitude'], 0.0001
    assert_in_delta(-122.4194, first['longitude'], 0.0001)
  end

  test 'vehicles skips entities that have no Vehicle, Trip, or Position' do
    body = {
      'Entities' => [
        { 'Vehicle' => { 'Trip' => { 'RouteId' => 'N' },
                         'Position' => { 'Latitude' => 37.76, 'Longitude' => -122.42 } } },
        { 'Vehicle' => nil },                         # no Vehicle
        { 'Vehicle' => { 'Trip' => nil,               # no Trip
                         'Position' => { 'Latitude' => 37.76, 'Longitude' => -122.42 } } },
        { 'Vehicle' => { 'Trip' => { 'RouteId' => 'F' },
                         'Position' => nil } } # no Position
      ]
    }.to_json

    stub_request(:get, /api\.511\.org.*VehiclePositions/)
      .to_return(status: 200, body: body,
                 headers: { 'Content-Type' => 'application/json' })

    get '/munis/vehicles'

    assert_response :success
    assert_equal 1, response.parsed_body['items'].length
  end

  test 'vehicles returns empty items when 511 API returns no entities' do
    stub_request(:get, /api\.511\.org.*VehiclePositions/)
      .to_return(status: 200,
                 body: { 'Entities' => [] }.to_json,
                 headers: { 'Content-Type' => 'application/json' })

    get '/munis/vehicles'

    assert_response :success
    assert_equal [], response.parsed_body['items']
  end

  test 'vehicles returns 500 JSON when 511 API raises a network error' do
    stub_request(:get, /api\.511\.org.*VehiclePositions/)
      .to_raise(StandardError.new('connection refused'))

    get '/munis/vehicles'

    assert_response :internal_server_error
    assert response.parsed_body.key?('error'), 'error key expected in response'
  end

  test 'vehicles returns 500 JSON when 511 API responds with bad JSON' do
    stub_request(:get, /api\.511\.org.*VehiclePositions/)
      .to_return(status: 200, body: 'not json',
                 headers: { 'Content-Type' => 'application/json' })

    get '/munis/vehicles'

    assert_response :internal_server_error
    assert response.parsed_body.key?('error')
  end

  # ── GET /munis/:route_name/average ─────────────────────────────────────────

  test 'average returns full muni JSON for a known route' do
    get "/munis/#{munis(:geary).route_name}/average"

    assert_response :success
    data = response.parsed_body
    assert_equal munis(:geary).route_name, data['route_name']
    assert_equal munis(:geary).avg_smell_rating, data['avg_smell_rating']
    assert_equal munis(:geary).avg_clean_rating, data['avg_clean_rating']
    assert_equal munis(:geary).avg_driver_rating, data['avg_driver_rating']
  end

  test 'average returns null for an unknown route' do
    get '/munis/999/average'

    assert_response :success
    assert_equal 'null', response.body
  end
end
