require "test_helper"

class TopPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_template "top_pages/home"
    assert_select 'title', '勤怠管理'
  end
end
