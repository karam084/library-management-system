require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirmations" do
    get students_confirmations_url
    assert_response :success
  end
end
