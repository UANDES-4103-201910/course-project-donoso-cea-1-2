require "application_system_test_case"

class FlagPostsTest < ApplicationSystemTestCase
  setup do
    @flag_post = flag_posts(:one)
  end

  test "visiting the index" do
    visit flag_posts_url
    assert_selector "h1", text: "Flag Posts"
  end

  test "creating a Flag post" do
    visit flag_posts_url
    click_on "New Flag Post"

    fill_in "Post", with: @flag_post.post_id
    fill_in "Reason", with: @flag_post.reason
    fill_in "User", with: @flag_post.user_id
    click_on "Create Flag post"

    assert_text "Flag post was successfully created"
    click_on "Back"
  end

  test "updating a Flag post" do
    visit flag_posts_url
    click_on "Edit", match: :first

    fill_in "Post", with: @flag_post.post_id
    fill_in "Reason", with: @flag_post.reason
    fill_in "User", with: @flag_post.user_id
    click_on "Update Flag post"

    assert_text "Flag post was successfully updated"
    click_on "Back"
  end

  test "destroying a Flag post" do
    visit flag_posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Flag post was successfully destroyed"
  end
end
