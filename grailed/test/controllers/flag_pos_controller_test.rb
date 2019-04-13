require 'test_helper'

class FlagPosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flag_po = flag_pos(:one)
  end

  test "should get index" do
    get flag_pos_url
    assert_response :success
  end

  test "should get new" do
    get new_flag_po_url
    assert_response :success
  end

  test "should create flag_po" do
    assert_difference('FlagPo.count') do
      post flag_pos_url, params: { flag_po: { post: @flag_po.post, reason: @flag_po.reason, user_id: @flag_po.user_id } }
    end

    assert_redirected_to flag_po_url(FlagPo.last)
  end

  test "should show flag_po" do
    get flag_po_url(@flag_po)
    assert_response :success
  end

  test "should get edit" do
    get edit_flag_po_url(@flag_po)
    assert_response :success
  end

  test "should update flag_po" do
    patch flag_po_url(@flag_po), params: { flag_po: { post: @flag_po.post, reason: @flag_po.reason, user_id: @flag_po.user_id } }
    assert_redirected_to flag_po_url(@flag_po)
  end

  test "should destroy flag_po" do
    assert_difference('FlagPo.count', -1) do
      delete flag_po_url(@flag_po)
    end

    assert_redirected_to flag_pos_url
  end
end
