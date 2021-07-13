require 'test_helper'

class TodoesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todoes_index_url
    assert_response :success
  end

  test "should get new" do
    get todoes_new_url
    assert_response :success
  end

end
