require 'test_helper'

class DoingcheckControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get doingcheck_index_url
    assert_response :success
  end

  test "should get new" do
    get doingcheck_new_url
    assert_response :success
  end

  test "should get edit" do
    get doingcheck_edit_url
    assert_response :success
  end

end
