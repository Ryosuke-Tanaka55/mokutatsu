require 'test_helper'

class SubgoalcheckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subgoalcheck_index_url
    assert_response :success
  end

  test "should get new" do
    get subgoalcheck_new_url
    assert_response :success
  end

  test "should get edit" do
    get subgoalcheck_edit_url
    assert_response :success
  end

end
