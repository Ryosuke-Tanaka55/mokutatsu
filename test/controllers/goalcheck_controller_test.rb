require 'test_helper'

class GoalcheckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get goalcheck_index_url
    assert_response :success
  end

  test "should get new" do
    get goalcheck_new_url
    assert_response :success
  end

  test "should get edit" do
    get goalcheck_edit_url
    assert_response :success
  end

end
