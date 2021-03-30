require 'test_helper'

class PurchaseInfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_info = purchase_infos(:one)
  end

  test "should get index" do
    get purchase_infos_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_info_url
    assert_response :success
  end

  test "should create purchase_info" do
    assert_difference('PurchaseInfo.count') do
      post purchase_infos_url, params: { purchase_info: { buyer_premium: @purchase_info.buyer_premium, date: @purchase_info.date, invoice_number: @purchase_info.invoice_number, location: @purchase_info.location, purchase_type: @purchase_info.purchase_type, sale_price: @purchase_info.sale_price, shipping: @purchase_info.shipping, source: @purchase_info.source, total_cost: @purchase_info.total_cost } }
    end

    assert_redirected_to purchase_info_url(PurchaseInfo.last)
  end

  test "should show purchase_info" do
    get purchase_info_url(@purchase_info)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_info_url(@purchase_info)
    assert_response :success
  end

  test "should update purchase_info" do
    patch purchase_info_url(@purchase_info), params: { purchase_info: { buyer_premium: @purchase_info.buyer_premium, date: @purchase_info.date, invoice_number: @purchase_info.invoice_number, location: @purchase_info.location, purchase_type: @purchase_info.purchase_type, sale_price: @purchase_info.sale_price, shipping: @purchase_info.shipping, source: @purchase_info.source, total_cost: @purchase_info.total_cost } }
    assert_redirected_to purchase_info_url(@purchase_info)
  end

  test "should destroy purchase_info" do
    assert_difference('PurchaseInfo.count', -1) do
      delete purchase_info_url(@purchase_info)
    end

    assert_redirected_to purchase_infos_url
  end
end
