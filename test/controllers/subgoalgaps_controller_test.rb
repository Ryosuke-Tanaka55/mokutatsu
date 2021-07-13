require 'test_helper'

class SubgoalgapsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subgoalgaps_new_url
    assert_response :success
  end

  test "should get index" do
    get subgoalgaps_index_url
    assert_response :success
  end

end
