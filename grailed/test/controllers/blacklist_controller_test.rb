require 'test_helper'

class BlacklistControllerTest < ActionDispatch::IntegrationTest
  test "should get theblacklist" do
    get blacklist_theblacklist_url
    assert_response :success
  end

end
