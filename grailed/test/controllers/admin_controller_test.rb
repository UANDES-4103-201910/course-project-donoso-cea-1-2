require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get admins" do
    get admin_admins_url
    assert_response :success
  end

end
