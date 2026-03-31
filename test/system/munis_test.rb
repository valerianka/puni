require 'application_system_test_case'

class MunisSystemTest < ApplicationSystemTestCase
  # ── Home page structure ────────────────────────────────────────────────────

  test 'home page shows the bus component and rating form' do
    stub_511_api
    visit root_path

    assert_selector 'img[alt="Puni logo"]'
    assert_selector '.bus'
    assert_selector '.rating-form'
  end

  test 'home page has three sliders: smell, clean, driver' do
    stub_511_api
    visit root_path

    assert_selector '#range_smell'
    assert_selector '#range_clean'
    assert_selector '#range_driver'
  end

  test 'submit button is disabled until a route is set' do
    stub_511_api
    visit root_path

    submit = find('#submit-btn')
    assert submit[:disabled], 'submit button should start disabled'
  end

  # ── Full submission flow ───────────────────────────────────────────────────
  # Grant fake geolocation → stub 511 API → wait for route to resolve →
  # fill sliders → submit → verify leaderboard.

  test 'full flow: geolocation resolves route, user submits rating, sees leaderboard' do
    stub_511_api(vehicles: [{ route_id: 'N', lat: 37.7749, lng: -122.4194 }])

    override_geolocation(lat: 37.7749, lng: -122.4194)
    visit root_path

    # Wait for JS to resolve the nearest bus and enable the submit button
    assert_selector '#submit-btn:not([disabled])', wait: 10

    # Verify the route was filled in
    assert_equal 'N', find('#route_name_tag').text

    set_sliders(smell: 4, clean: 3, driver: 5)
    click_button 'Submit your rating'

    assert_selector '.leaderboard', wait: 5
  end

  test 'form can be submitted with a comment' do
    stub_511_api(vehicles: [{ route_id: '38', lat: 37.7749, lng: -122.4194 }])

    override_geolocation
    visit root_path

    assert_selector '#submit-btn:not([disabled])', wait: 10

    set_sliders(smell: 2, clean: 2, driver: 1)
    fill_in 'comment', with: 'Bus smelled like old socks'
    click_button 'Submit your rating'

    assert_selector '.leaderboard', wait: 5
    assert Story.last.content.include?('old socks')
  end

  # ── Leaderboard navigation ─────────────────────────────────────────────────

  test 'leaderboard shows the Puni logo with a link back to home' do
    submit_rating_via_browser(route_id: munis(:geary).route_name,
                              smell: 3, clean: 4, driver: 2)

    assert_selector 'a[href="/"] img[alt="Puni logo"]'
  end

  test '"Rate Another Ride" button navigates back to home' do
    submit_rating_via_browser(route_id: munis(:geary).route_name,
                              smell: 3, clean: 3, driver: 3)

    click_link 'Rate Another Ride'

    assert_current_path root_path
  end

  private

  # Set all three range input values via JS (avoids flaky drag interactions).
  def set_sliders(smell:, clean:, driver:)
    page.execute_script("document.getElementById('range_smell').value  = '#{smell}'")
    page.execute_script("document.getElementById('range_clean').value  = '#{clean}'")
    page.execute_script("document.getElementById('range_driver').value = '#{driver}'")
  end

  # Drive the full form submission through the browser without relying on
  # geolocation — useful when we just need to land on the leaderboard.
  def submit_rating_via_browser(route_id:, smell:, clean:, driver:)
    stub_511_api
    visit root_path

    # Simulate what the JS does after geolocation + vehicles succeed
    page.execute_script(<<~JS)
      document.getElementById('route_name').value           = '#{route_id}';
      document.getElementById('route_name_tag').textContent = '#{route_id}';
      document.getElementById('submit-btn').removeAttribute('disabled');
      document.getElementById('submit-btn').disabled = false;
    JS

    set_sliders(smell: smell, clean: clean, driver: driver)
    click_button 'Submit your rating'

    assert_selector '.leaderboard', wait: 5
  end
end
