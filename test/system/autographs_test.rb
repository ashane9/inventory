require "application_system_test_case"

class AutographsTest < ApplicationSystemTestCase
  setup do
    @autograph = autographs(:one)
  end

  test "visiting the index" do
    visit autographs_url
    assert_selector "h1", text: "Autographs"
  end

  test "creating a Autograph" do
    visit autographs_url
    click_on "New Autograph"

    fill_in "Authentication", with: @autograph.authentication
    fill_in "Authentication number", with: @autograph.authentication_number
    fill_in "Name", with: @autograph.name
    click_on "Create Autograph"

    assert_text "Autograph was successfully created"
    click_on "Back"
  end

  test "updating a Autograph" do
    visit autographs_url
    click_on "Edit", match: :first

    fill_in "Authentication", with: @autograph.authentication
    fill_in "Authentication number", with: @autograph.authentication_number
    fill_in "Name", with: @autograph.name
    click_on "Update Autograph"

    assert_text "Autograph was successfully updated"
    click_on "Back"
  end

  test "destroying a Autograph" do
    visit autographs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Autograph was successfully destroyed"
  end
end
