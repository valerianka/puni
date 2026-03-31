require 'test_helper'

class MuniTest < ActiveSupport::TestCase
  # ── Validations ────────────────────────────────────────────────────────────

  test 'valid with route_name and ratings in range' do
    muni = Muni.new(route_name: '99', avg_smell_rating: 3, avg_clean_rating: 3, avg_driver_rating: 3)
    assert muni.valid?
  end

  test 'invalid without route_name' do
    muni = Muni.new(avg_smell_rating: 3, avg_clean_rating: 3, avg_driver_rating: 3)
    assert_not muni.valid?
    assert_includes muni.errors[:route_name], "can't be blank"
  end

  test 'invalid with duplicate route_name' do
    muni = Muni.new(route_name: munis(:geary).route_name, avg_smell_rating: 3, avg_clean_rating: 3,
                    avg_driver_rating: 3)
    assert_not muni.valid?
    assert_includes muni.errors[:route_name], 'has already been taken'
  end

  test 'invalid when avg rating is below 1' do
    muni = Muni.new(route_name: '99', avg_smell_rating: 0, avg_clean_rating: 3, avg_driver_rating: 3)
    assert_not muni.valid?
  end

  test 'invalid when avg rating is above 5' do
    muni = Muni.new(route_name: '99', avg_smell_rating: 3, avg_clean_rating: 6, avg_driver_rating: 3)
    assert_not muni.valid?
  end

  test 'valid at boundary values 1 and 5' do
    muni = Muni.new(route_name: '99', avg_smell_rating: 1, avg_clean_rating: 5, avg_driver_rating: 3)
    assert muni.valid?
  end

  # ── average_of ─────────────────────────────────────────────────────────────
  # geary has two reports: [smell:3,clean:4,driver:2] and [smell:5,clean:5,driver:5]
  # smell:  (3+5)/2 = 4.0  → 4
  # clean:  (4+5)/2 = 4.5  → 5  (Ruby rounds .5 up)
  # driver: (2+5)/2 = 3.5  → 4

  test 'average_of returns correctly rounded average' do
    muni = munis(:geary)
    assert_equal 4, muni.average_of('smell_rating')
    assert_equal 5, muni.average_of('clean_rating')
    assert_equal 4, muni.average_of('driver_rating')
  end

  test 'average_of does not floor on fractional averages' do
    muni = munis(:geary)
    # (4+5)/2 = 4.5 should round to 5, not floor to 4
    assert_equal 5, muni.average_of('clean_rating')
  end

  # ── update_averages ────────────────────────────────────────────────────────

  test 'update_averages sets all avg fields from reports' do
    muni = munis(:geary)
    muni.update_averages
    assert_equal 4, muni.avg_smell_rating
    assert_equal 5, muni.avg_clean_rating
    assert_equal 4, muni.avg_driver_rating
  end

  # ── average_sum ────────────────────────────────────────────────────────────

  test 'average_sum is the sum of all three avg ratings' do
    muni = munis(:geary)
    assert_equal muni.avg_smell_rating + muni.avg_clean_rating + muni.avg_driver_rating, muni.average_sum
  end

  # ── sorted_munis ───────────────────────────────────────────────────────────

  test 'sorted_munis orders by descending average_sum' do
    sorted = Muni.sorted_munis
    sums = sorted.map(&:average_sum)
    assert_equal sums.sort.reverse, sums
  end

  test 'sorted_munis puts higher-rated route first' do
    sorted = Muni.sorted_munis
    # geary avg_sum = 3+4+2 = 9, mission avg_sum = 2+2+2 = 6
    assert_equal munis(:geary).route_name, sorted.first.route_name
  end
end
