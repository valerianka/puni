require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # ── Validations ────────────────────────────────────────────────────────────

  test 'valid with all ratings in range' do
    report = Report.new(smell_rating: 3, clean_rating: 3, driver_rating: 3, muni: munis(:geary))
    assert report.valid?
  end

  test 'valid at boundary values 1 and 5' do
    report = Report.new(smell_rating: 1, clean_rating: 5, driver_rating: 1, muni: munis(:geary))
    assert report.valid?
  end

  test 'invalid with smell_rating below 1' do
    report = Report.new(smell_rating: 0, clean_rating: 3, driver_rating: 3, muni: munis(:geary))
    assert_not report.valid?
  end

  test 'invalid with smell_rating above 5' do
    report = Report.new(smell_rating: 6, clean_rating: 3, driver_rating: 3, muni: munis(:geary))
    assert_not report.valid?
  end

  test 'invalid with clean_rating below 1' do
    report = Report.new(smell_rating: 3, clean_rating: 0, driver_rating: 3, muni: munis(:geary))
    assert_not report.valid?
  end

  test 'invalid with clean_rating above 5' do
    report = Report.new(smell_rating: 3, clean_rating: 6, driver_rating: 3, muni: munis(:geary))
    assert_not report.valid?
  end

  test 'invalid with driver_rating below 1' do
    report = Report.new(smell_rating: 3, clean_rating: 3, driver_rating: 0, muni: munis(:geary))
    assert_not report.valid?
  end

  test 'invalid with driver_rating above 5' do
    report = Report.new(smell_rating: 3, clean_rating: 3, driver_rating: 6, muni: munis(:geary))
    assert_not report.valid?
  end

  # ── Associations ───────────────────────────────────────────────────────────

  test 'belongs to its muni' do
    assert_equal munis(:geary), reports(:report_one).muni
  end

  test 'can have a story' do
    assert_equal stories(:one), reports(:report_one).story
  end
end
