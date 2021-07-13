require 'test_helper'

class DoingControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get doing_new_url
    assert_response :success
  end

end
