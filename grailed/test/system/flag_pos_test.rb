require "application_system_test_case"

class FlagPosTest < ApplicationSystemTestCase
  setup do
    @flag_po = flag_pos(:one)
  end

  test "visiting the index" do
    visit flag_pos_url
    assert_selector "h1", text: "Flag Pos"
  end

  test "creating a Flag po" do
    visit flag_pos_url
    click_on "New Flag Po"

    fill_in "Post", with: @flag_po.post
    fill_in "Reason", with: @flag_po.reason
    fill_in "User", with: @flag_po.user_id
    click_on "Create Flag po"

    assert_text "Flag po was successfully created"
    click_on "Back"
  end

  test "updating a Flag po" do
    visit flag_pos_url
    click_on "Edit", match: :first

    fill_in "Post", with: @flag_po.post
    fill_in "Reason", with: @flag_po.reason
    fill_in "User", with: @flag_po.user_id
    click_on "Update Flag po"

    assert_text "Flag po was successfully updated"
    click_on "Back"
  end

  test "destroying a Flag po" do
    visit flag_pos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Flag po was successfully destroyed"
  end
end
