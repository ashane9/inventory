require "application_system_test_case"

class PurchaseInfosTest < ApplicationSystemTestCase
  setup do
    @purchase_info = purchase_infos(:one)
  end

  test "visiting the index" do
    visit purchase_infos_url
    assert_selector "h1", text: "Purchase Infos"
  end

  test "creating a Purchase info" do
    visit purchase_infos_url
    click_on "New Purchase Info"

    fill_in "Buyer premium", with: @purchase_info.buyer_premium
    fill_in "Date", with: @purchase_info.date
    fill_in "Invoice number", with: @purchase_info.invoice_number
    fill_in "Location", with: @purchase_info.location
    fill_in "Purchase type", with: @purchase_info.purchase_type
    fill_in "Sale price", with: @purchase_info.sale_price
    fill_in "Shipping", with: @purchase_info.shipping
    fill_in "Source", with: @purchase_info.source
    fill_in "Total cost", with: @purchase_info.total_cost
    click_on "Create Purchase info"

    assert_text "Purchase info was successfully created"
    click_on "Back"
  end

  test "updating a Purchase info" do
    visit purchase_infos_url
    click_on "Edit", match: :first

    fill_in "Buyer premium", with: @purchase_info.buyer_premium
    fill_in "Date", with: @purchase_info.date
    fill_in "Invoice number", with: @purchase_info.invoice_number
    fill_in "Location", with: @purchase_info.location
    fill_in "Purchase type", with: @purchase_info.purchase_type
    fill_in "Sale price", with: @purchase_info.sale_price
    fill_in "Shipping", with: @purchase_info.shipping
    fill_in "Source", with: @purchase_info.source
    fill_in "Total cost", with: @purchase_info.total_cost
    click_on "Update Purchase info"

    assert_text "Purchase info was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase info" do
    visit purchase_infos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase info was successfully destroyed"
  end
end
