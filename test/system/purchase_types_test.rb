require "application_system_test_case"

class PurchaseTypesTest < ApplicationSystemTestCase
  setup do
    @purchase_type = purchase_types(:one)
  end

  test "visiting the index" do
    visit purchase_types_url
    assert_selector "h1", text: "Purchase Types"
  end

  test "creating a Purchase type" do
    visit purchase_types_url
    click_on "New Purchase Type"

    fill_in "Type", with: @purchase_type.type
    click_on "Create Purchase type"

    assert_text "Purchase type was successfully created"
    click_on "Back"
  end

  test "updating a Purchase type" do
    visit purchase_types_url
    click_on "Edit", match: :first

    fill_in "Type", with: @purchase_type.type
    click_on "Update Purchase type"

    assert_text "Purchase type was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase type" do
    visit purchase_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase type was successfully destroyed"
  end
end
