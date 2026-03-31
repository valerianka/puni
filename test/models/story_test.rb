require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  # ── Validations ────────────────────────────────────────────────────────────

  test 'valid with content' do
    story = Story.new(content: 'Great ride!', report: reports(:report_two))
    assert story.valid?
  end

  test 'invalid without content' do
    story = Story.new(report: reports(:report_two))
    assert_not story.valid?
    assert_includes story.errors[:content], "can't be blank"
  end

  # ── Associations ───────────────────────────────────────────────────────────

  test 'belongs to its report' do
    assert_equal reports(:report_one), stories(:one).report
  end
end
