require 'test_helper'

class DumpsterControllerTest < ActionDispatch::IntegrationTest
  test "should get thedumpster" do
    get dumpster_thedumpster_url
    assert_response :success
  end

end
