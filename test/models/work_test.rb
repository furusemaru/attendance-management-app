require "test_helper"

class WorkTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @work = @user.works.build(start_time: "2024-02-19 15:46:19", end_time: "2024-02-19 13:46:19", comment: 'test', total_hours: 2, date: "2024-02-19")
  end

  test "should be valid" do
    assert @work.valid?
  end

  test "user id should be present" do
    @work.user_id = nil
    assert_not @work.valid?
  end

  test "start/end time should be present" do
    @work.start_time = nil
    assert_not @work.valid?
    @work.start_time = "2024-02-19 15:46:19"
    @work.end_time = nil
    assert_not @work.valid?
  end

  test "order should be most recent first" do
    assert_equal works(:most_recent), Work.first
  end
end
