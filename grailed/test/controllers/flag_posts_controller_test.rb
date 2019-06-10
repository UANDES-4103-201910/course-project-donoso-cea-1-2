require 'test_helper'

class FlagPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flag_post = flag_posts(:one)
  end

  test "should get index" do
    get flag_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_flag_post_url
    assert_response :success
  end

  test "should create flag_post" do
    assert_difference('FlagPost.count') do
      post flag_posts_url, params: { flag_post: { post_id: @flag_post.post_id, reason: @flag_post.reason, user_id: @flag_post.user_id } }
    end

    assert_redirected_to flag_post_url(FlagPost.last)
  end

  test "should show flag_post" do
    get flag_post_url(@flag_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_flag_post_url(@flag_post)
    assert_response :success
  end

  test "should update flag_post" do
    patch flag_post_url(@flag_post), params: { flag_post: { post_id: @flag_post.post_id, reason: @flag_post.reason, user_id: @flag_post.user_id } }
    assert_redirected_to flag_post_url(@flag_post)
  end

  test "should destroy flag_post" do
    assert_difference('FlagPost.count', -1) do
      delete flag_post_url(@flag_post)
    end

    assert_redirected_to flag_posts_url
  end
end
