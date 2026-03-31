require 'test_helper'

class MunisControllerTest < ActionDispatch::IntegrationTest
  # ── GET / (index) ──────────────────────────────────────────────────────────

  test 'GET index returns 200' do
    get root_path
    assert_response :success
  end

  # ── POST /leaderboard (show) ───────────────────────────────────────────────

  test 'POST leaderboard creates a new muni and report' do
    assert_difference ['Muni.count', 'Report.count'], 1 do
      post '/leaderboard', params: {
        route_name: '71',
        smell_rating: 3,
        clean_rating: 4,
        driver_rating: 2
      }
    end
    assert_response :success
  end

  test 'POST leaderboard finds existing muni instead of creating a duplicate' do
    assert_no_difference 'Muni.count' do
      assert_difference 'Report.count', 1 do
        post '/leaderboard', params: {
          route_name: munis(:geary).route_name,
          smell_rating: 5,
          clean_rating: 5,
          driver_rating: 5
        }
      end
    end
  end

  test 'POST leaderboard updates muni averages after new report' do
    post '/leaderboard', params: {
      route_name: '72',
      smell_rating: 5,
      clean_rating: 5,
      driver_rating: 5
    }
    muni = Muni.find_by(route_name: '72')
    assert_equal 5, muni.avg_smell_rating
    assert_equal 5, muni.avg_clean_rating
    assert_equal 5, muni.avg_driver_rating
  end

  test 'POST leaderboard creates a story when a comment is provided' do
    assert_difference 'Story.count', 1 do
      post '/leaderboard', params: {
        route_name: '73',
        smell_rating: 3,
        clean_rating: 3,
        driver_rating: 3,
        comment: 'Driver was very friendly'
      }
    end
  end

  test 'POST leaderboard skips story when comment is blank' do
    assert_no_difference 'Story.count' do
      post '/leaderboard', params: {
        route_name: '74',
        smell_rating: 3,
        clean_rating: 3,
        driver_rating: 3,
        comment: ''
      }
    end
  end

  test 'POST leaderboard renders the leaderboard on success' do
    post '/leaderboard', params: {
      route_name: '75',
      smell_rating: 3,
      clean_rating: 3,
      driver_rating: 3
    }
    assert_response :success
    assert_select 'body'
  end

  # ── GET /munis/:route_name/average ─────────────────────────────────────────

  test 'GET average returns muni data as JSON' do
    get "/munis/#{munis(:geary).route_name}/average"
    assert_response :success
    data = response.parsed_body
    assert_equal munis(:geary).route_name, data['route_name']
  end

  test 'GET average returns null JSON for unknown route' do
    get '/munis/999/average'
    assert_response :success
    assert_equal 'null', response.body
  end
end
