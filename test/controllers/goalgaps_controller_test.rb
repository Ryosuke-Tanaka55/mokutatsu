require 'test_helper'

class GoalgapsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get goalgaps_new_url
    assert_response :success
  end

  test "should get index" do
    get goalgaps_index_url
    assert_response :success
  end

end
